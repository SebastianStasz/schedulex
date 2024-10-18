//
//  NextDayScheduleModel.swift
//  SchedulexTests
//
//  Created by Sebastian Staszczyk on 18/10/2024.
//

import Foundation
@testable import UEK_Schedule

struct NextDayScheduleModel {
    let date: String
    let events: [FacultyGroupEventModel]

    func toNextDaySchedule() -> NextDaySchedule {
        NextDaySchedule(date: date.toDate(),
                        events: events.map { $0.toFacultyGroupEvent() })
    }
}
