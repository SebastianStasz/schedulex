//
//  ScheduleEventsEntryModel.swift
//  SchedulexTests
//
//  Created by Sebastian Staszczyk on 18/10/2024.
//

import Foundation
@testable import UEK_Schedule

struct ScheduleEventsEntryModel {
    private let date: String
    private let events: [FacultyGroupEventModel]
    private let nextDaySchedule: NextDayScheduleModel?

    init(date: String, events: [FacultyGroupEventModel], _ nextDaySchedule: NextDayScheduleModel? = nil) {
        self.date = date
        self.events = events
        self.nextDaySchedule = nextDaySchedule
    }

    func toScheduleEventsEntry() -> ScheduleEventsEntry {
        ScheduleEventsEntry(date: date.toDate(),
                            events: events.map { $0.toFacultyGroupEvent() },
                            nextDaySchedule: nextDaySchedule?.toNextDaySchedule())
    }
}
