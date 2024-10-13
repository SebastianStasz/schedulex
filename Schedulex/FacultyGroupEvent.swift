//
//  FacultyGroupEvent.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 11/06/2024.
//

import Domain
import Foundation

struct FacultyGroupEvent: Hashable, Identifiable, Codable {
    let facultyGroupName: String
    let color: FacultyGroupColor
    let event: Event

    var startDate: Date { event.startDate }
    var endDate: Date { event.endDate }

    var id: UUID { event.id }
}

typealias FacultyGroupEventsByDay = [Date: [FacultyGroupEvent]]

extension FacultyGroupEventsByDay {
    var allEvents: [Event] {
        flatMap { $0.value.map { $0.event } }
    }

    func mapToFacultyGroupEventsByDate() -> [FacultyGroupEventsByDate] {
        keys.sorted().compactMap { key in
            guard let events = self[key] else { return nil }
            return FacultyGroupEventsByDate(date: key, events: events)
        }
    }
}
