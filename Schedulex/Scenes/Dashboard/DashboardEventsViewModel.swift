//
//  DashboardEventsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/01/2024.
//

import Combine
import Domain
import Foundation
import SchedulexCore
import UEKScraper
import Widgets

struct DashboardEventsViewModel {
    struct Input {
        let fetchEvents: Driver<Void>
        let forceRefresh: Driver<Void>
        let facultyGroups: Driver<[FacultyGroup]>
        let daysOff: Driver<[DayOff]>
        let hiddenClasses: Driver<[EditableFacultyGroupClass]>
    }

    struct Output {
        let dayPickerItems: Driver<[DayPickerItem]?>
        let facultiesGroupsDetails: Driver<[FacultyGroupDetails]>
        let facultyGroupEventsByDay: Driver<FacultyGroupEventsByDay>
        let isLoading: Driver<Bool>
        let errorTracker: Driver<Error>
    }

    private let service = UekScheduleService()

    func makeOutput(input: Input) -> Output {
        let isLoading = DriverState(false)
        let errorTracker = DriverSubject<Error>()
        var nextUpdateDate: Date?

        let errorHandler = errorTracker
            .onNext { _ in nextUpdateDate = nil }

        let facultyGroups = input.facultyGroups
            .removeDuplicates()
            .onNext { _ in nextUpdateDate = nil }

        let fetchEvents = input.fetchEvents
            .filter { shouldRefreshEvents(nextUpdateDate: nextUpdateDate) }

        let fetchEventsForFacultyGroups = Merge(fetchEvents, input.forceRefresh)
            .withLatestFrom(facultyGroups)

        let allFacultiesGroupsDetails = fetchEventsForFacultyGroups
            .perform(isLoading: isLoading, errorTracker: errorTracker) { try await fetchFacultiesGroupsDetails(for: $0) }
            .onNext { _ in nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 5, to: .now) }
            .share()

        let facultyGroupEventsByDay = CombineLatest(allFacultiesGroupsDetails, input.hiddenClasses)
            .onNext { _ in isLoading.send(true) }
            .map { $0.0.mapToEventsWithoutHiddenClasses(hiddenClasses: $0.1) }
            .map { groupEventsByDate($0) }
            .share()

        let dayPickerItems = CombineLatest(facultyGroupEventsByDay, input.daysOff)
            .receive(on: DispatchQueue.global(qos: .background))
            .map { $0.0.mapToDayPickerItems(daysOff: $0.1) }
            .receive(on: DispatchQueue.main)
            .onNext { _ in isLoading.send(false) }

        return Output(dayPickerItems: dayPickerItems.asDriver(),
                      facultiesGroupsDetails: allFacultiesGroupsDetails.asDriver(),
                      facultyGroupEventsByDay: facultyGroupEventsByDay.asDriver(),
                      isLoading: isLoading.asDriver(),
                      errorTracker: errorHandler.asDriver())
    }

    private func shouldRefreshEvents(nextUpdateDate: Date?) -> Bool {
        guard let nextUpdateDate else { return true }
        return nextUpdateDate <= Date.now
    }

    private func fetchFacultiesGroupsDetails(for facultyGroups: [FacultyGroup]) async throws -> [FacultyGroupDetails] {
        var facultyGroupsDetails: [FacultyGroupDetails] = []
        for facultyGroup in facultyGroups {
            let facultyGroupDetails = try await service.getFacultyGroupDetails(for: facultyGroup)
            facultyGroupsDetails.append(facultyGroupDetails)
        }
        return facultyGroupsDetails
    }

    private func groupEventsByDate(_ events: [FacultyGroupEvent]) -> FacultyGroupEventsByDay {
        Dictionary(grouping: events, by: { Calendar.current.startOfDay(for: $0.startDate) })
            .mapValues { $0.sorted(by: { $0.startDate < $1.startDate }) }
    }
}

private extension [FacultyGroupDetails] {
    func mapToEventsWithoutHiddenClasses(hiddenClasses: [EditableFacultyGroupClass]) -> [FacultyGroupEvent] {
        var events: [FacultyGroupEvent] = []
        for facultyGroupDetails in self {
            guard !facultyGroupDetails.isHidden else { continue }
            let hiddenClasses = hiddenClasses
                .filter { $0.facultyGroupName == facultyGroupDetails.name }
                .map { $0.toFacultyGroupClass() }

            let newEvents = facultyGroupDetails.events
                .filter { !hiddenClasses.contains($0.class) }
                .map { $0.toFacultyGroupEvent(facultyGroup: facultyGroupDetails) }

            events.append(contentsOf: newEvents)
        }
        return events
    }
}

private extension FacultyGroupEventsByDay {
    func mapToDayPickerItems(daysOff: [DayOff]) -> [DayPickerItem]? {
        guard let startDate = keys.min(), let endDate = keys.max() else { return nil }

        let stopDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)!
        var dates: [Date] = []
        var date = startDate

        while date < stopDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }

        return dates.map { date in
            let hasFreeHours = daysOff.contains(where: { $0.date.isSameDay(as: date) })
            let specificDate = Calendar.current.startOfDay(for: date)
            if let events = self[specificDate] {
                let colors = Set(events.map { $0.color })
                    .sorted(by: { $0.id < $1.id })
                    .map { $0.representative }
                return DayPickerItem(date: date, circleColors: colors, hasFreeHours: hasFreeHours)
            }
            return DayPickerItem(date: date, circleColors: [], hasFreeHours: hasFreeHours)
        }
    }
}
