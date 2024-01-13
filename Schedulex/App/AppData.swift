//
//  AppData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Domain
import Foundation

final class AppData {
    private let defaults: UserDefaults

    var subscribedFacultyGroups: [FacultyGroup] = [] {
        didSet {
            let data = try! JSONEncoder().encode(subscribedFacultyGroups)
            let json = String(data: data, encoding: .utf8)
            defaults.setValue(json, forKey: "subscribedFacultyGroups")
        }
    }

    var showDashboardSwipeTip = true {
        didSet { defaults.setValue(showDashboardSwipeTip, forKey: "showDashboardSwipeTip") }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        showDashboardSwipeTip = defaults.bool(forKey: "showDashboardSwipeTip")

        if let data = UserDefaults.standard.value(forKey: "subscribedFacultyGroups") as? Data {
            let subscribedFacultyGroups = try? JSONDecoder().decode([FacultyGroup].self, from: data)
            self.subscribedFacultyGroups = subscribedFacultyGroups ?? []
        }
    }
}
