//
//  AppData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Domain
import Foundation
import Widgets

public final class AppData {
    private let defaults: UserDefaults

    @Published public private(set) var subscribedFacultyGroups: [FacultyGroup] = [] {
        didSet {
            let groups = subscribedFacultyGroups.sorted(by: { $0.name < $1.name })
            let data = try! JSONEncoder().encode(groups)
            let json = String(data: data, encoding: .utf8)
            defaults.setValue(json, forKey: "subscribedFacultyGroups")
        }
    }

    @Published public private(set) var allHiddenClasses: [EditableFacultyGroupClass] = [] {
        didSet {
            let data = try! JSONEncoder().encode(allHiddenClasses)
            let json = String(data: data, encoding: .utf8)
            defaults.setValue(json, forKey: "allHiddenClasses")
        }
    }

    @Published public private(set) var hiddenInfoCards: [InfoCard] = [] {
        didSet { defaults.set(hiddenInfoCards.map { $0.rawValue }, forKey: "hiddenInfoCards") }
    }

    @Published public var classNotificationsEnabled: Bool = false {
        didSet { defaults.set(classNotificationsEnabled, forKey: "classNotificationsEnabled") }
    }

    @Published public var classNotificationsTime: ClassNotificationTime = .oneHourBefore {
        didSet { defaults.set(classNotificationsTime.rawValue, forKey: "classNotificationsTime") }
    }

    @Published public var dashboardSwipeTipPresented: Bool = true {
        didSet { defaults.setValue(dashboardSwipeTipPresented, forKey: "dashboardSwipeTipPresented") }
    }

    @Published public var appColorScheme: AppColorScheme = .system {
        didSet { defaults.set(appColorScheme.rawValue, forKey: "appColorScheme") }
    }

    private var didResetRateTheApplicationInfoCard: Bool

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        classNotificationsEnabled = defaults.bool(forKey: "classNotificationsEnabled")
        dashboardSwipeTipPresented = defaults.bool(forKey: "dashboardSwipeTipPresented")

        if let rawValues = defaults.stringArray(forKey: "hiddenInfoCards") {
            hiddenInfoCards = rawValues.compactMap { InfoCard(rawValue: $0) }
        }

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
            allHiddenClasses = subscribedFacultyGroups ?? []
        }

        didResetRateTheApplicationInfoCard = defaults.bool(forKey: "didResetRateTheApplicationInfoCard")
        if !didResetRateTheApplicationInfoCard {
            hiddenInfoCards.removeAll(where: { $0 == .rateTheApplication })
            defaults.set(true, forKey: "didResetRateTheApplicationInfoCard")
        }
    }

    private var availableColors: [FacultyGroupColor] {
        FacultyGroupColor.allCases.filter { color in
            !subscribedFacultyGroups.contains(where: { $0.color == color })
        }
    }
}

public extension AppData {
    func hideInfoCard(_ infoCard: InfoCard) {
        if !hiddenInfoCards.contains(infoCard) {
            hiddenInfoCards.append(infoCard)
        }
    }

    func subscribeFacultyGroup(_ facultyGroup: FacultyGroup) {
        guard !subscribedFacultyGroups.contains(where: { $0.name == facultyGroup.name }) else {
            return
        }
        var facultyGroup = facultyGroup
        facultyGroup.color = availableColors.first ?? .default
        subscribedFacultyGroups.append(facultyGroup)
    }

    func subscribeFacultyGroups(_ facultyGroups: [FacultyGroup]) {
        facultyGroups.forEach { subscribeFacultyGroup($0) }
    }

    func unsubscribeFacultyGroup(_ facultyGroup: FacultyGroup) {
        subscribedFacultyGroups.removeAll { $0.name == facultyGroup.name }
        allHiddenClasses.removeAll { $0.facultyGroupName == facultyGroup.name }
    }

    func toggleFacultyGroupVisibility(_ facultyGroup: FacultyGroup) {
        if let index = subscribedFacultyGroups.firstIndex(where: { $0.name == facultyGroup.name }) {
            subscribedFacultyGroups[index].isHidden.toggle()
        }
    }

    func hideFacultyGroupClass(_ facultyGroupClass: EditableFacultyGroupClass) {
        guard !allHiddenClasses.contains(facultyGroupClass) else { return }
        allHiddenClasses.append(facultyGroupClass)
    }

    func unhideFacultyGroupClass(_ facultyGroupClass: EditableFacultyGroupClass) {
        allHiddenClasses.removeAll(where: { $0 == facultyGroupClass })
    }

    func setFacultyGroupColor(for facultyGroup: FacultyGroup, color: FacultyGroupColor) {
        guard let index = subscribedFacultyGroups.firstIndex(where: { $0.name == facultyGroup.name }) else { return }
        subscribedFacultyGroups[index].color = color
    }

    func updateNumberOfEventsForSubscribedFacultyGroups(from facultyGroupsDetails: [FacultyGroupDetails]) {
        for facultyGroupDetail in facultyGroupsDetails {
            if let index = subscribedFacultyGroups.firstIndex(where: { $0.name == facultyGroupDetail.name }) {
                subscribedFacultyGroups[index].numberOfEvents = facultyGroupDetail.events.count
            }
        }
    }
}
