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
            saveDataAsJson(groups, forKey: "subscribedFacultyGroups")
        }
    }

    @Published public private(set) var allHiddenClasses: [EditableFacultyGroupClass] = [] {
        didSet { saveDataAsJson(allHiddenClasses, forKey: "allHiddenClasses") }
    }

    @Published public private(set) var hiddenInfoCards: [InfoCard] = [] {
        didSet { defaults.set(hiddenInfoCards.map { $0.rawValue }, forKey: "hiddenInfoCards") }
    }

    @Published public var classNotificationsEnabled = false {
        didSet { defaults.set(classNotificationsEnabled, forKey: "classNotificationsEnabled") }
    }

    @Published public var classNotificationsTime: ClassNotificationTime = .oneHourBefore {
        didSet { defaults.set(classNotificationsTime.rawValue, forKey: "classNotificationsTime") }
    }

    @Published public var dashboardSwipeTipPresented = true {
        didSet { defaults.setValue(dashboardSwipeTipPresented, forKey: "dashboardSwipeTipPresented") }
    }

    @Published public var appColorScheme: AppColorScheme = .system {
        didSet { defaults.set(appColorScheme.rawValue, forKey: "appColorScheme") }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        subscribedFacultyGroups = getObject(ofType: [FacultyGroup].self, forKey: "subscribedFacultyGroups") ?? []
        allHiddenClasses = getObject(ofType: [EditableFacultyGroupClass].self, forKey: "allHiddenClasses") ?? []

        classNotificationsEnabled = defaults.bool(forKey: "classNotificationsEnabled")
        dashboardSwipeTipPresented = defaults.bool(forKey: "dashboardSwipeTipPresented")

        appColorScheme = getEnum(ofType: AppColorScheme.self, forKey: "appColorScheme") ?? .system
        classNotificationsTime = getEnum(ofType: ClassNotificationTime.self, forKey: "classNotificationsTime") ?? .oneHourBefore

        if let rawValues = defaults.stringArray(forKey: "hiddenInfoCards") {
            hiddenInfoCards = rawValues.compactMap { InfoCard(rawValue: $0) }
        }

        let didResetRateTheApplicationInfoCard = defaults.bool(forKey: "didResetRateTheApplicationInfoCard")
        if !didResetRateTheApplicationInfoCard {
            hiddenInfoCards.removeAll(where: { $0 == .rateTheApplication })
            defaults.set(true, forKey: "didResetRateTheApplicationInfoCard")
        }
    }
}

private extension AppData {
    var availableColors: [FacultyGroupColor] {
        FacultyGroupColor.allCases.filter { color in
            !subscribedFacultyGroups.contains(where: { $0.color == color })
        }
    }

    func saveDataAsJson<T: Encodable>(_ data: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(data),
              let json = String(data: data, encoding: .utf8)
        else { return }
        defaults.setValue(json, forKey: key)
    }

    func getObject<T: Decodable>(ofType type: T.Type, forKey key: String) -> T? {
        guard let string = defaults.value(forKey: key) as? String,
              let data = string.data(using: .utf8)
        else { return nil }
        return try? JSONDecoder().decode(type.self, from: data)
    }

    func getEnum<T: RawRepresentable>(ofType: T.Type, forKey key: String) -> T? where T.RawValue == String {
        guard let rawValue = defaults.string(forKey: key) else { return nil }
        return T(rawValue: rawValue)
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
