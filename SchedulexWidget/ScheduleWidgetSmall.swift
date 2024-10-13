//
//  ScheduleWidgetSmall.swift
//  SchedulexWidget
//
//  Created by Sebastian Staszczyk on 10/10/2024.
//

import Domain
import SwiftUI
import WidgetKit

struct ScheduleWidgetSmall: Widget {
    private let kind: String = "ScheduleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ScheduleWidgetProvider()) { entry in
            ScheduleWidgetView(entry: entry)
        }
        .configurationDisplayName("UEK Schedule")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    ScheduleWidgetSmall()
} timeline: {
    ScheduleEventsEntry(date: .now, events: [])
    ScheduleEventsEntry(date: .now, events: [.sample, .sample2, .sample3])
    ScheduleEventsEntry(date: .now, events: [.sample], nextDaySchedule: NextDaySchedule(date: Calendar.current.date(byAdding: .day, value: 1, to: .now)!, events: [.sample2, .sample3]))
    ScheduleEventsEntry(date: .now, events: [], nextDaySchedule: NextDaySchedule(date: Calendar.current.date(byAdding: .day, value: 1, to: .now)!, events: [.sample2, .sample3]))
    ScheduleEventsEntry(date: .now, events: [.sample])
}
