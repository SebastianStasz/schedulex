//
//  DashboardEventsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/01/2024.
//

import Combine
import Domain
import Foundation
import Widgets
import UEKScraper

struct DashboardEventsViewModel {
    struct Input {
        let fetchEvents: Driver<Void>
        let facultyGroups: Driver<[FacultyGroup]>
        let hiddenClasses: Driver<[EditableFacultyGroupClass]>
    }

    struct Output {
        let dayPickerItems: Driver<[DayPickerItem]?>
        let eventsToDisplay: Driver<[Event]>
        let isLoading: Driver<Bool>
    }

    private let service = UekScheduleService()

    func makeOutput(input: Input) -> Output {
        let isLoading = DriverState(false)
        var nextUpdateDate: Date?

        let fetchEvents = input.fetchEvents
            .filter { !shouldUseCachedData(nextUpdateDate: nextUpdateDate) }
            .share()

        let allEvents = CombineLatest(fetchEvents, input.facultyGroups)
            .onNext { _, _ in isLoading.send(true) }
            .perform { _, facultyGroups in try await fetchFacultyGroupsEvents(for: facultyGroups) }
            .onNext { _ in nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 5, to: .now) }
            .removeDuplicates()

        let eventsToDisplay = CombineLatest(allEvents, input.hiddenClasses)
            .map { $0.0.mapToEventsWithoutHiddenClasses(hiddenClasses: $0.1) }

        let dayPickerItems = eventsToDisplay
            .receive(on: DispatchQueue.global(qos: .background))
            .map { $0.mapToDayPickerItems() }
            .receive(on: DispatchQueue.main)
            .onNext { _ in isLoading.send(false) }

        return Output(dayPickerItems: dayPickerItems.asDriver(),
                      eventsToDisplay: eventsToDisplay.asDriver(),
                      isLoading: isLoading.asDriver())
    }

    private func shouldUseCachedData(nextUpdateDate: Date?) -> Bool {
        guard let nextUpdateDate, nextUpdateDate >= Date.now else {
            return false
        }
        return true
    }

    private func fetchFacultyGroupsEvents(for facultyGroups: [FacultyGroup]) async throws -> [FacultyGroupDetails] {
        var facultyGroupsDetails: [FacultyGroupDetails] = []
        for facultyGroup in facultyGroups {
            guard !facultyGroup.isHidden else { continue }
            let facultyGroupDetails = try await service.getFacultyGroupDetails(for: facultyGroup)
            facultyGroupsDetails.append(facultyGroupDetails)
        }
        return facultyGroupsDetails
    }
}

private extension [FacultyGroupDetails] {
    func mapToEventsWithoutHiddenClasses(hiddenClasses: [EditableFacultyGroupClass]) -> [Event] {
        var events: [Event] = []
        for facultyGroupDetails in self {
            let hiddenClasses = hiddenClasses
                .filter { $0.facultyGroupName == facultyGroupDetails.name }
                .map { $0.toFacultyGroupClass() }

            let newEvents = facultyGroupDetails.events
                .filter { !hiddenClasses.contains($0.class) }

            events.append(contentsOf: newEvents)
        }
        return events
    }
}

private extension [Event] {
    func mapToDayPickerItems() -> [DayPickerItem]? {
        let eventsByDate = self.sorted(by: { $0.startDate! < $1.startDate! })
        
        guard let startDate = eventsByDate.first?.startDate,
              let endDate = eventsByDate.last?.startDate
        else { return nil }

        let stopDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)!
        var dates: [Date] = []
        var date = startDate
        
        while date < stopDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }

        let eventsByDay = Dictionary(grouping: eventsByDate, by: { $0.startDate?.formatted(date: .numeric, time: .omitted) })

        return dates.map { date in
            if let events = eventsByDay[date.formatted(date: .numeric, time: .omitted)] {
                let colors = Set(events.map { $0.facultyGroupColor })
                    .sorted(by: { $0.id < $1.id })
                    .map { $0.representative }
                return DayPickerItem(date: date, circleColors: colors)
            }
            return DayPickerItem(date: date, circleColors: [])
        }
    }
}
