//
//  FacultyGroupEventsByDayCodable.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Foundation

struct FacultyGroupEventsByDayCodable: Codable {
    private let eventsByDate: [String: [FacultyGroupEvent]]

    init(eventsByDate: FacultyGroupEventsByDay) {
        let dateFormatter = ISO8601DateFormatter()
        self.eventsByDate = eventsByDate.reduce(into: [String: [FacultyGroupEvent]]()) { result, pair in
            let dateString = dateFormatter.string(from: pair.key)
            result[dateString] = pair.value
        }
    }

    func toDateKeyedDictionary() -> FacultyGroupEventsByDay {
        let formatter = ISO8601DateFormatter()
        return eventsByDate.reduce(into: FacultyGroupEventsByDay()) { result, pair in
            if let date = formatter.date(from: pair.key) {
                result[date] = pair.value
            }
        }
    }
}
