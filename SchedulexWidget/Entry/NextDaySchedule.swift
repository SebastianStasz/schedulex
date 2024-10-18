//
//  NextDaySchedule.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Foundation

struct NextDaySchedule: Equatable {
    let date: Date
    let events: [FacultyGroupEvent]

    var numberOfEvents: Int {
        events.count
    }
}
