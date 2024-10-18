//
//  AppGroupData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Foundation

struct AppGroupData: AppGroupDataProvider {
    private let defaults = UserDefaults(suiteName: "group.com.Schedulex")

    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    func saveFacultyGroupEventsByDate(_ events: FacultyGroupEventsByDay) {
        let wrapper = FacultyGroupEventsByDayCodable(eventsByDate: events)
        guard let data = try? encoder.encode(wrapper) else { return }
        defaults?.set(data, forKey: "facultyGroupEventsByDate")
    }

    func getFacultyGroupEventsByDate() -> FacultyGroupEventsByDay {
        guard let data = defaults?.data(forKey: "facultyGroupEventsByDate") else { return [:] }
        let wrapper = try? decoder.decode(FacultyGroupEventsByDayCodable.self, from: data)
        return wrapper?.toDateKeyedDictionary() ?? [:]
    }
}
