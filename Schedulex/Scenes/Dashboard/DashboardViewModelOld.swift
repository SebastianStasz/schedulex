//
//  DashboardViewModelOld.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Combine
import Domain
import Foundation
import Resources
import UEKScraper
import Widgets

@MainActor
final class DashboardViewModelOld: ObservableObject {
    @Published private(set) var dayPickerItems: [DayPickerItem]? = nil
    @Published private(set) var selectedDateEvents: [Event] = []
    @Published private(set) var startDate: Date?
    @Published private(set) var endDate: Date?
    @Published private(set) var isLoading = true

    @Published private var nextUpdateDate: Date?
    @Published private(set) var allEvents: [Event] = []
//    @Published var shouldScrollToDay = false
    @Published var selectedDate: Date = .now

    private let service = UekScheduleService()
    private var cancellables: Set<AnyCancellable> = []

    var isEmpty: Bool {
        allEvents.isEmpty
    }

    var shouldUseCachedData: Bool {
        guard let nextUpdateDate, nextUpdateDate >= Date.now else {
            return false
        }
        return true
    }
}
