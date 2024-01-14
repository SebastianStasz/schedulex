//
//  AppData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Domain
import Foundation

struct AppData {
    private let defaults: UserDefaults

    private(set) var subscribedFacultyGroups: [FacultyGroup] = [] {
        didSet {
            let groups = subscribedFacultyGroups.sorted(by: { $0.name < $1.name })
            let data = try! JSONEncoder().encode(groups)
            let json = String(data: data, encoding: .utf8)
            defaults.setValue(json, forKey: "subscribedFacultyGroups")
        }
    }

    private(set) var allHiddenClasses: [EditableFacultyGroupClass] = []

    var showDashboardSwipeTip = true {
        didSet { defaults.setValue(showDashboardSwipeTip, forKey: "showDashboardSwipeTip") }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        showDashboardSwipeTip = defaults.bool(forKey: "showDashboardSwipeTip")

        if let string = UserDefaults.standard.value(forKey: "subscribedFacultyGroups") as? String, let data = string.data(using: .utf8) {
            let subscribedFacultyGroups = try? JSONDecoder().decode([FacultyGroup].self, from: data)
            self.subscribedFacultyGroups = subscribedFacultyGroups ?? []
        }
    }

    mutating func subscribeFacultyGroups(_ facultyGroups: [FacultyGroup]) {
        subscribedFacultyGroups.append(contentsOf: facultyGroups)
    }

    mutating func toggleFacultyGroupVisibility(_ facultyGroup: FacultyGroup) {
        if let index = subscribedFacultyGroups.firstIndex(where: { $0.name == facultyGroup.name }) {
            subscribedFacultyGroups[index].isHidden.toggle()
        }
    }

    mutating func deleteFacultyGroup(_ facultyGroup: FacultyGroup) {
        subscribedFacultyGroups.removeAll { $0.name == facultyGroup.name }
        allHiddenClasses.removeAll { $0.facultyGroupName == facultyGroup.name }
    }
}
