//
//  ScheduleDataProvider.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/10/2024.
//

import Foundation

struct ScheduleDataProvider {
    private let currentDate: Date
    private let eventsByDay: FacultyGroupEventsByDay
    private let events: [FacultyGroupEvent]
    private let daysWithEvents: [Date]

    init(appGroupData: AppGroupDataProvider = AppGroupData()) {
        let facultyGroupEventsByDay = appGroupData.getFacultyGroupEventsByDate()
        let currentDate = DateUtils.date

        self.currentDate = currentDate
        eventsByDay = facultyGroupEventsByDay

        let uniqueEvents = eventsByDay.allFacultyGroupEvents
            .filter { $0.endDate >= currentDate }
            .reduce(into: [Date: FacultyGroupEvent]()) { $0[$1.startDate] = $1 }
        
        events = Array(uniqueEvents.values).sorted(by: { $0.startDate < $1.startDate })

        if let firstEvent = events.first {
            daysWithEvents = eventsByDay.keys.sorted().filter { $0 >= Calendar.current.startOfDay(for: firstEvent.startDate) }
        } else {
            daysWithEvents = []
        }
    }

    func getScheduleEventEntries() -> [ScheduleEventsEntry] {
        var previousEventEndDate: Date?
        var entries = events
            .flatMap { event in
                let currentDay = Calendar.current.startOfDay(for: event.startDate)
                let currentDayEvents = eventsByDay[currentDay]?.filter { $0.startDate >= event.startDate } ?? []
                let nextDaySchedule = getNextDayScheduleWithEvents(after: currentDay)
                let entry = ScheduleEventsEntry(date: previousEventEndDate ?? currentDay, events: currentDayEvents, nextDaySchedule: nextDaySchedule)
                previousEventEndDate = event.endDate

                var additionalEntry: ScheduleEventsEntry?
                let uniqueCurrentDayEvents = Set(currentDayEvents.map { $0.startDate })
                if uniqueCurrentDayEvents.count == 1, let refresh = nextDaySchedule?.date {
                    previousEventEndDate = refresh
                    additionalEntry = ScheduleEventsEntry(date: event.endDate, events: [], nextDaySchedule: nextDaySchedule)
                }
                return [entry, additionalEntry].compactMap { $0 }
            }
            .sorted(by: { $0.date < $1.date })

        if let firstEntry = makeFirstEntryIfNeeded() {
            entries.insert(firstEntry, at: 0)
        }

        if let lastEntry = entries.last {
            entries.append(ScheduleEventsEntry(date: previousEventEndDate ?? lastEntry.date, events: []))
        }
        
        return entries
    }

    private func getNextDayScheduleWithEvents(after date: Date) -> NextDaySchedule? {
        guard let nextDay = daysWithEvents.first(where: { $0 > date }),
              let nextDayEvents = eventsByDay[nextDay]
        else { return nil }
        return NextDaySchedule(date: nextDay, events: nextDayEvents)
    }

    private func makeFirstEntryIfNeeded() -> ScheduleEventsEntry? {
        guard let firstDayWithEvent = daysWithEvents.first,
              !firstDayWithEvent.isSameDay(as: currentDate)
        else { return nil }
        let nextDaySchedule = getNextDayScheduleWithEvents(after: currentDate)
        let startOfCurrentDate = Calendar.current.startOfDay(for: currentDate)
        return ScheduleEventsEntry(date: startOfCurrentDate, events: [], nextDaySchedule: nextDaySchedule)
    }
}
