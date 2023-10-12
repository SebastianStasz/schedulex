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

    @Published private var nextUpdateDate: Date?
    @Published private var allEvents: [Event] = []
    @Published var shouldScrollToDay = false
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

    var shouldUseCachedData: Bool {
        guard let nextUpdateDate, nextUpdateDate >= Date.now else {
            return false
        }
        return true
    }

    func fetchEvents(for facultyGroups: [FacultyGroup], hiddenClasses: [EditableFacultyGroupClass]) async throws {
        isLoading = true
        var events: [Event] = []
        for facultyGroup in facultyGroups {
            guard !facultyGroup.isHidden else {
                continue
            }
            let facultyGroupDetails = try await service.getFacultyGroupDetails(for: facultyGroup)
            let hiddenClasses = hiddenClasses
                .filter { $0.facultyGroupName == facultyGroup.name }
                .map { $0.toFacultyGroupClass() }
            
            let newEvents = facultyGroupDetails.events
                .filter { !hiddenClasses.contains($0.class) }

            events.append(contentsOf: newEvents)
        }
        allEvents = events
        nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 5, to: .now)
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
            .delay(for: .milliseconds(50), scheduler: DispatchQueue.main)
            .map { [weak self] startDate, endDate in
                self?.shouldScrollToDay = true
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
                    .filter { $0.startDate?.isSameDay(as: selectedDate) ?? false }
                    .sorted(by: { $0.startDate! < $1.startDate! })
            }
            .assign(to: &$selectedDateEvents)
    }
}
