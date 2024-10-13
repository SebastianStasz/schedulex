//
//  ScheduleEventsEntry.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 10/10/2024.
//

import Domain
import WidgetKit

struct ScheduleEventsEntry: TimelineEntry {
    let date: Date
    let events: [FacultyGroupEvent]
    let nextDaySchedule: NextDaySchedule?

    init(date: Date, events: [FacultyGroupEvent], nextDaySchedule: NextDaySchedule? = nil) {
        self.date = date
        self.events = events
        self.nextDaySchedule = nextDaySchedule
    }
}
