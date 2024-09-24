//
//  DashboardViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Combine
import Domain
import SchedulexCore
import SchedulexViewModel
import UEKScraper
import UIKit
import Widgets

final class DashboardStore: RootStore {
    @Published var selectedDate: Date = .now
    @Published var dayPickerItems: [DayPickerItem]?
    let infoCardsSectionStore: InfoCardsSectionStore

    @Published fileprivate(set) var dayOff: DayOff?
    @Published fileprivate(set) var selectedDateEvents: [FacultyGroupEvent] = []
    @Published fileprivate(set) var showInfoToUnhideFacultyGroups = false
    @Published fileprivate(set) var showDashboardSwipeTip = false
    @Published fileprivate(set) var showSettingsBadge = false
    @Published fileprivate(set) var showErrorInfo = false
    @Published fileprivate(set) var isLoading = true
    @Published fileprivate(set) var startDate: Date?
    @Published fileprivate(set) var endDate: Date?

    let navigateTo = DriverSubject<DashboardViewModel.Destination>()
    let markSwipeTipAsPresented = DriverSubject<Void>()
    let selectTodaysDate = DriverSubject<Void>()
    let scrollToDate = DriverSubject<Void>()
    let refresh = DriverSubject<Void>()

    var isDefaultDateSelected: Bool {
        let defaultSelectedDate = getDefaultSelectedDate()
        return selectedDate.isSameDay(as: defaultSelectedDate)
    }

    init(infoCardsSectionStore: InfoCardsSectionStore) {
        self.infoCardsSectionStore = infoCardsSectionStore
        super.init()
    }

    fileprivate func getDefaultSelectedDate() -> Date {
        let todaysDate = Date.now
        guard let startDate, let endDate, startDate > todaysDate || endDate < todaysDate else { return todaysDate }
        return Date.now < startDate ? startDate : endDate
    }
}

struct DashboardViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let notificationManager = NotificationsManager()

    func makeStore(context: Context) -> DashboardStore {
        var nextSelectedDateResetDate: Date = .now

        let infoCardsSectionStore = InfoCardsSectionViewModel(notificationsManager: notificationManager)
            .makeStore(appData: context.appData)

        let store = DashboardStore(infoCardsSectionStore: infoCardsSectionStore)
        let viewWillEnterForeground = NotificationCenter.willEnterForeground
        let viewWillAppearOrWillEnterForeground = Merge(store.viewWillAppear, viewWillEnterForeground)
        let subscribedFacultyGroups = context.appData.$subscribedFacultyGroups
        let daysOff = context.storage.appConfiguration.map { $0.daysOff }

        let setDefaultSelectedDate = { [weak store] in
            let dateToSelect = store?.getDefaultSelectedDate() ?? .now
            guard !(store?.selectedDate.isSameDay(as: dateToSelect) ?? true) else {
                store?.scrollToDate.send()
                return
            }
            store?.selectedDate = dateToSelect
        }

        NotificationCenter.didEnterBackground
            .sink { nextSelectedDateResetDate = Calendar.current.date(byAdding: .minute, value: 5, to: .now)! }
            .store(in: &store.cancellables)

        viewWillEnterForeground
            .sink(on: store) {
                if nextSelectedDateResetDate < .now {
                    setDefaultSelectedDate()
                }
            }

        store.selectTodaysDate
            .sink(on: store) {
                setDefaultSelectedDate()
            }

        viewWillAppearOrWillEnterForeground
            .perform { await notificationManager.updateNotificationsPermission() }
            .sink(on: store)

        subscribedFacultyGroups
            .map { $0.filter { !$0.isHidden }.isEmpty }
            .assign(to: &store.$showInfoToUnhideFacultyGroups)

        let dashboardEventsOutput = DashboardEventsViewModel()
            .makeOutput(input: .init(fetchEvents: viewWillAppearOrWillEnterForeground.asDriver(),
                                     forceRefresh: store.refresh.asDriver(),
                                     facultyGroups: subscribedFacultyGroups.asDriver(),
                                     daysOff: daysOff.asDriver(),
                                     hiddenClasses: context.appData.$allHiddenClasses.asDriver()))

        dashboardEventsOutput.isLoading
            .assign(to: &store.$isLoading)

        dashboardEventsOutput.errorTracker
            .sink(on: store) { store, _ in
                store.showErrorInfo = true
                store.selectedDateEvents = []
                store.selectedDate = .now
                store.dayPickerItems = nil
                store.startDate = nil
                store.endDate = nil
            }

        dashboardEventsOutput.dayPickerItems
            .sink(on: store) {
                let startDate = $1?.first?.date
                let endDate = $1?.last?.date
                $0.startDate = startDate
                $0.endDate = endDate
                $0.dayPickerItems = $1
                setDefaultSelectedDate()
                if let items = $1, !items.isEmpty {
                    store.showInfoToUnhideFacultyGroups = false
                    store.showErrorInfo = false
                }
            }

        dashboardEventsOutput.facultiesGroupsDetails
            .sink { context.appData.updateNumberOfEventsForSubscribedFacultyGroups(from: $0) }
            .store(in: &store.cancellables)

        let classNotificationServiceInput = ClassNotificationService.Input(
            events: dashboardEventsOutput.eventsToDisplay.map { $0.map { $0.event } }.asDriver(),
            classNotificationsEnabled: context.appData.$classNotificationsEnabled.asDriver(),
            classNotificationsTime: context.appData.$classNotificationsTime.asDriver()
        )

        ClassNotificationService(notificationsManager: notificationManager)
            .registerForEventsNotifications(input: classNotificationServiceInput)
            .sink(on: store)

        CombineLatest(store.$selectedDate, dashboardEventsOutput.eventsToDisplay)
            .map { getSelectedDayEvents(date: $0, events: $1) }
            .assign(to: &store.$selectedDateEvents)

        CombineLatest(store.$selectedDate, daysOff)
            .map { date, daysOff in daysOff.first(where: { $0.date.isSameDay(as: date) }) }
            .assign(to: &store.$dayOff)

        context.storage.appConfiguration
            .sink(on: store) { $0.showSettingsBadge = $1.isAppUpdateAvailable }

        context.appData.$dashboardSwipeTipPresented
            .map { !$0 }
            .assign(to: &store.$showDashboardSwipeTip)

        store.markSwipeTipAsPresented
            .sink { context.appData.dashboardSwipeTipPresented = true }
            .store(in: &store.cancellables)

        store.navigateTo
            .sink { navigate(to: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func getSelectedDayEvents(date: Date, events: [FacultyGroupEvent]) -> [FacultyGroupEvent] {
        events
            .filter { $0.startDate?.isSameDay(as: date) ?? false }
            .sorted(by: { $0.startDate! < $1.startDate! })
    }
}
