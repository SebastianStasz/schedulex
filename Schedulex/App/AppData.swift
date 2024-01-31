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

    private(set) var allHiddenClasses: [EditableFacultyGroupClass] = [] {
        didSet {
            let data = try! JSONEncoder().encode(allHiddenClasses)
            let json = String(data: data, encoding: .utf8)
            defaults.setValue(json, forKey: "allHiddenClasses")
        }
    }

    var classNotificationsEnabled: Bool = false {
        didSet { defaults.set(classNotificationsEnabled, forKey: "classNotificationsEnabled") }
    }

    var classNotificationsTime: ClassNotificationTime = .oneHourBefore {
        didSet { defaults.set(classNotificationsTime.rawValue, forKey: "classNotificationsTime") }
    }

    var showDashboardSwipeTip: Bool = true {
        didSet { defaults.setValue(showDashboardSwipeTip, forKey: "showDashboardSwipeTip") }
    }

    var appColorScheme: AppColorScheme = .system {
        didSet { defaults.set(appColorScheme.rawValue, forKey: "appColorScheme") }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        classNotificationsEnabled = defaults.bool(forKey: "classNotificationsEnabled")
        showDashboardSwipeTip = defaults.bool(forKey: "showDashboardSwipeTip")
        
        if let rawValue = defaults.string(forKey: "appColorScheme"), let appColorScheme = AppColorScheme(rawValue: rawValue) {
            self.appColorScheme = appColorScheme
        }

        if let rawValue = defaults.string(forKey: "classNotificationsTime"), let classNotificationsTime = ClassNotificationTime(rawValue: rawValue) {
            self.classNotificationsTime = classNotificationsTime
        }

        if let string = UserDefaults.standard.value(forKey: "subscribedFacultyGroups") as? String, let data = string.data(using: .utf8) {
            let subscribedFacultyGroups = try? JSONDecoder().decode([FacultyGroup].self, from: data)
            self.subscribedFacultyGroups = subscribedFacultyGroups ?? []
        }

        if let string = UserDefaults.standard.value(forKey: "allHiddenClasses") as? String, let data = string.data(using: .utf8) {
            let subscribedFacultyGroups = try? JSONDecoder().decode([EditableFacultyGroupClass].self, from: data)
            self.allHiddenClasses = subscribedFacultyGroups ?? []
        }
    }

    mutating func subscribeFacultyGroup(_ facultyGroup: FacultyGroup) {
        guard !subscribedFacultyGroups.contains(where: { $0.name == facultyGroup.name }) else {
            return
        }
        var facultyGroup = facultyGroup
        facultyGroup.color = availableColors.first ?? .default
        subscribedFacultyGroups.append(facultyGroup)
    }

    mutating func subscribeFacultyGroups(_ facultyGroups: [FacultyGroup]) {
        facultyGroups.forEach { subscribeFacultyGroup($0) }
    }

    mutating func unsubscribeFacultyGroup(_ facultyGroup: FacultyGroup) {
        subscribedFacultyGroups.removeAll { $0.name == facultyGroup.name }
        allHiddenClasses.removeAll { $0.facultyGroupName == facultyGroup.name }
    }

    mutating func toggleFacultyGroupVisibility(_ facultyGroup: FacultyGroup) {
        if let index = subscribedFacultyGroups.firstIndex(where: { $0.name == facultyGroup.name }) {
            subscribedFacultyGroups[index].isHidden.toggle()
        }
    }

    mutating func hideFacultyGroupClass(_ facultyGroupClass: EditableFacultyGroupClass) {
        guard !allHiddenClasses.contains(facultyGroupClass) else { return }
        allHiddenClasses.append(facultyGroupClass)
    }

    mutating func unhideFacultyGroupClass(_ facultyGroupClass: EditableFacultyGroupClass) {
        allHiddenClasses.removeAll(where: { $0 == facultyGroupClass })
    }

    mutating func setFacultyGroupColor(for facultyGroup: FacultyGroup, color: FacultyGroupColor) {
        guard let index = subscribedFacultyGroups.firstIndex(where: { $0.name == facultyGroup.name }) else { return }
        subscribedFacultyGroups[index].color = color
    }

    private var availableColors: [FacultyGroupColor] {
        FacultyGroupColor.allCases.filter { color in
            !subscribedFacultyGroups.contains(where: { $0.color == color })
        }
    }
}
