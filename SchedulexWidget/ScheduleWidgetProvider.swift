//
//  ScheduleWidgetProvider.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 10/10/2024.
//

import Domain
import SwiftUI
import WidgetKit

struct ScheduleWidgetProvider: TimelineProvider {
    private let appGroupData = AppGroupData()

    func placeholder(in context: Context) -> ScheduleEventsEntry {
        ScheduleEventsEntry(date: .now, events: [.sample, .sample2])
    }

    @MainActor
    func getSnapshot(in context: Context, completion: @escaping (ScheduleEventsEntry) -> Void) {
        let eventsByDate = appGroupData.getFacultyGroupEventsByDate() ?? []
        guard let firstDay = eventsByDate.first else {
            let entry = placeholder(in: context)
            completion(entry)
            return
        }
        let entry = ScheduleEventsEntry(date: firstDay.date, events: firstDay.events)
        completion(entry)
    }

    @MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let eventsByDate = appGroupData.getFacultyGroupEventsByDate() ?? []
        var previousEventEndDate: Date?

        var entries = eventsByDate
            .flatMap { $0.events }
            .map { event in
                let sameDay = eventsByDate.first(where: { $0.date == Calendar.current.startOfDay(for: event.startDate) })
                let nextEvents = sameDay?.events.filter { $0.startDate > event.startDate } ?? []
                let refreshDate = previousEventEndDate ?? event.startDate
                previousEventEndDate = event.endDate

                let nextDayDate = Calendar.current.date(byAdding: .day, value: 1, to: event.startDate)!
                let nextDayEvents = eventsByDate.first(where: { $0.date == Calendar.current.startOfDay(for: nextDayDate) })?.events ?? []
                let nextDaySchedule = NextDaySchedule(date: nextDayDate, events: nextDayEvents)
                return ScheduleEventsEntry(date: refreshDate, events: [event] + nextEvents, nextDaySchedule: nextDaySchedule)
            }

        entries.append(ScheduleEventsEntry(date: previousEventEndDate ?? entries.last?.date ?? .now, events: []))

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
