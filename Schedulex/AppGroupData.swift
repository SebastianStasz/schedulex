//
//  AppGroupData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Foundation

struct AppGroupData {
    private let defaults = UserDefaults(suiteName: "group.com.Schedulex")

    func saveFacultyGroupEventsByDate(_ events: [FacultyGroupEventsByDate]) {
        guard let data = try? JSONEncoder().encode(events) else { return }
        defaults?.set(data, forKey: "facultyGroupEventsByDate")
    }

    func getFacultyGroupEventsByDate() -> [FacultyGroupEventsByDate]? {
        guard let data = defaults?.data(forKey: "facultyGroupEventsByDate") else { return nil }
        return try? JSONDecoder().decode([FacultyGroupEventsByDate].self, from: data)
    }
}
