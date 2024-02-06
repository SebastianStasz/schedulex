//
//  DashboardViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Combine
import Domain
import UIKit
import Widgets
import UEKScraper

final class DashboardStore: RootStore {
    @Published var selectedDate: Date = .now
    let infoCardsSectionStore: InfoCardsSectionStore

    @Published fileprivate(set) var dayPickerItems: [DayPickerItem]?
    @Published fileprivate(set) var selectedDateEvents: [Event] = []
    @Published fileprivate(set) var showInfoToUnhideFacultyGroups = false
    @Published fileprivate(set) var showDashboardSwipeTip = false
    @Published fileprivate(set) var showSettingsBadge = false
    @Published fileprivate(set) var isLoading = true
    @Published fileprivate(set) var startDate: Date?
    @Published fileprivate(set) var endDate: Date?

    let navigateTo = DriverSubject<DashboardViewModel.Destination>()
    let markSwipeTipAsPresented = DriverSubject<Void>()

    init(infoCardsSectionStore: InfoCardsSectionStore) {
        self.infoCardsSectionStore = infoCardsSectionStore
        super.init()
    }
}

struct DashboardViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let notificationManager = NotificationsManager()

    func makeStore(context: Context) -> DashboardStore {
        let infoCardsSectionViewModel = InfoCardsSectionViewModel(notificationsManager: notificationManager)
        let infoCardsSectionStore = infoCardsSectionViewModel.makeStore(appData: context.appData)
        let store = DashboardStore(infoCardsSectionStore: infoCardsSectionStore)

        let viewWillAppearOrWillEnterForeground = Merge(store.viewWillAppear, NotificationCenter.willEnterForeground)
        let subscribedFacultyGroups = context.appData.$subscribedFacultyGroups

        context.storage.appConfiguration
            .sinkAndStore(on: store) { $0.showSettingsBadge = $1.isAppUpdateAvailable }

        viewWillAppearOrWillEnterForeground
            .perform { await notificationManager.updateNotificationsPermission() }
            .sinkAndStore(on: store) { _, _ in }

        context.appData.$dashboardSwipeTipPresented
            .map { !$0 }
            .assign(to: &store.$showDashboardSwipeTip)

        store.markSwipeTipAsPresented
            .sink { context.appData.dashboardSwipeTipPresented = true }
            .store(in: &store.cancellables)

        subscribedFacultyGroups
            .map { $0.filter { !$0.isHidden }.isEmpty }
            .assign(to: &store.$showInfoToUnhideFacultyGroups)

        let dashboardEventsOutput = DashboardEventsViewModel()
            .makeOutput(input: .init(fetchEvents: viewWillAppearOrWillEnterForeground.asDriver(),
                                     facultyGroups: subscribedFacultyGroups.asDriver(),
                                     hiddenClasses: context.appData.$allHiddenClasses.asDriver()))

        dashboardEventsOutput.isLoading
            .assign(to: &store.$isLoading)

        dashboardEventsOutput.dayPickerItems
            .sinkAndStore(on: store) {
                let startDate = $1?.first?.date
                let endDate = $1?.last?.date
                $0.startDate = startDate
                $0.endDate = endDate
                $0.dayPickerItems = $1
                store.selectedDate = getDefaultSelectedDate(startDate: startDate, endDate: endDate)
            }

        let classNotificationServiceInput = ClassNotificationService.Input(
            events: dashboardEventsOutput.eventsToDisplay,
            classNotificationsEnabled: context.appData.$classNotificationsEnabled.asDriver(),
            classNotificationsTime: context.appData.$classNotificationsTime.asDriver()
        )
        
        ClassNotificationService(notificationsManager: notificationManager)
            .registerForEventsNotifications(input: classNotificationServiceInput)
            .sinkAndStore(on: store) { _, _ in }

        CombineLatest(store.$selectedDate.dropFirst(), dashboardEventsOutput.eventsToDisplay)
            .map { getSelectedDayEvents(date: $0, events: $1) }
            .assign(to: &store.$selectedDateEvents)

        store.navigateTo
            .sink { navigate(to: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func getDefaultSelectedDate(startDate: Date?, endDate: Date?) -> Date {
        let todaysDate = Date.now
        guard let startDate, let endDate, startDate > todaysDate || endDate < todaysDate else { return todaysDate }
        return Date.now < startDate ? startDate : endDate
    }

    private func getSelectedDayEvents(date: Date, events: [Event]) -> [Event] {
        events
            .filter { $0.startDate?.isSameDay(as: date) ?? false }
            .sorted(by: { $0.startDate! < $1.startDate! })
    }
}
