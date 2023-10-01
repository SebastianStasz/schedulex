//
//  DashboardViewModel.swift
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
final class DashboardViewModel: ObservableObject {
    @Published private(set) var selectedDateEvents: [Event] = []
    @Published private(set) var startDate: Date?
    @Published private(set) var endDate: Date?
    @Published private(set) var isLoading = true

    @Published private var allEvents: [Event] = []
    @Published var selectedDate: Date = .now

    private let service = UekScheduleService()
    private var cancellables: Set<AnyCancellable> = []

    init() { bind() }

    var title: String {
        selectedDate.formatted(style: .dateLong)
    }

    var subtitle: String {
        selectedDate.isSameDay(as: .now) ? L10n.today : L10n.selectedDate
    }

    var isEmpty: Bool {
        allEvents.isEmpty
    }

    func fetchEvents(for facultyGroups: [FacultyGroup]) async throws {
        isLoading = true
        var events: [Event] = []
        for facultyGroup in facultyGroups {
            let facultyGroupEvents = try await service.getFacultyGroupEvents(for: facultyGroup)
            events.append(contentsOf: facultyGroupEvents.events)
        }
        allEvents = events
        isLoading = false
    }

    func bind() {
        $allEvents
            .map { $0.sorted(by: { $0.startDate! < $1.startDate! }) }
            .sink { [weak self] in
                self?.startDate = $0.first?.startDate
                self?.endDate = $0.last?.startDate
            }
            .store(in: &cancellables)

        CombineLatest($startDate.compactMap { $0 }, $endDate.compactMap { $0 })
            .map { startDate, endDate in
                let todayDate = Date.now
                if todayDate < startDate {
                    return startDate
                } else if todayDate > endDate {
                    return endDate
                } else {
                    return todayDate
                }
            }
            .assign(to: &$selectedDate)

        CombineLatest($allEvents, $selectedDate)
            .map { allEvents, selectedDate in
                allEvents
                    .filter { $0.startDate?.formatted(date: .numeric, time: .omitted) == selectedDate.formatted(date: .numeric, time: .omitted) }
                    .sorted(by: { $0.startDate! < $1.startDate! })
            }
            .assign(to: &$selectedDateEvents)
    }
}
