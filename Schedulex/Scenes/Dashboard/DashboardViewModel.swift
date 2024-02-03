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
    @Published var shouldScrollToDay = false

    @Published fileprivate(set) var dayPickerItems: [DayPickerItem]?
    @Published fileprivate(set) var selectedDateEvents: [Event] = []
    @Published fileprivate(set) var isLoading = true
    @Published fileprivate(set) var startDate: Date?
    @Published fileprivate(set) var endDate: Date?

    let navigateTo = DriverSubject<DashboardViewModel.Destination>()
}

struct DashboardViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let manager = NotificationsManager()

    func makeStore(context: Context) -> DashboardStore {
        let store = DashboardStore()

        let subscribedFacultyGroups = context.$appData.map { $0.subscribedFacultyGroups }

        let dashboardEventsOutput = DashboardEventsViewModel()
            .makeOutput(input: .init(viewWillAppear: store.viewWillAppear,
                                     facultyGroups: subscribedFacultyGroups.asDriver(),
                                     hiddenClasses: context.$appData.map { $0.allHiddenClasses }.asDriver()))

        dashboardEventsOutput.isLoading
            .assign(to: &store.$isLoading)

        dashboardEventsOutput.dayPickerItems
            .sinkAndStore(on: store) {
                let startDate = $1?.first?.date
                let endDate = $1?.last?.date
                $0.startDate = startDate
                $0.endDate = endDate
                $0.dayPickerItems = $1
                if let date = getDefaultSelectedDate(selectedDate: $0.selectedDate, startDate: startDate, endDate: endDate) {
                    store.selectedDate = date
                }
            }

        CombineLatest(store.$selectedDate, dashboardEventsOutput.events)
            .map { getSelectedDayEvents(date: $0, events: $1) }
            .assign(to: &store.$selectedDateEvents)

        store.navigateTo
            .sink { navigate(to: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func getDefaultSelectedDate(selectedDate: Date, startDate: Date?, endDate: Date?) -> Date? {
        guard let startDate, let endDate, startDate > selectedDate || endDate < selectedDate else { return nil }
        return Date.now < startDate ? startDate : endDate
    }

    private func getSelectedDayEvents(date: Date, events: [Event]) -> [Event] {
        events
            .filter { $0.startDate?.isSameDay(as: date) ?? false }
            .sorted(by: { $0.startDate! < $1.startDate! })
    }
}
