//
//  FacultyGroupEventsByDay.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Domain
import Foundation

typealias FacultyGroupEventsByDay = [Date: [FacultyGroupEvent]]

extension FacultyGroupEventsByDay {
    var allEvents: [Event] {
        values.flatMap { $0.map { $0.event } }
    }

    var allFacultyGroupEvents: [FacultyGroupEvent] {
        values.flatMap { $0 }
    }
}
