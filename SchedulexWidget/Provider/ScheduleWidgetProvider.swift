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
    @MainActor
    func placeholder(in context: Context) -> ScheduleEventsEntry {
        ScheduleEventsEntry(date: DateUtils.date, events: [.sample, .sample2])
    }

    @MainActor
    func getSnapshot(in context: Context, completion: @escaping (ScheduleEventsEntry) -> Void) {
//        let eventsByDate = getFacultyGroupEventsByDate()
//        guard let firstDay = eventsByDate.first else {
//            completion(placeholder(in: context))
//            return
//        }
        let entry = ScheduleEventsEntry(date: DateUtils.date, events: [])
        completion(entry)
    }

    @MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let dataProvider = ScheduleDataProvider()
        let entries = dataProvider.getScheduleEventEntries()
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
