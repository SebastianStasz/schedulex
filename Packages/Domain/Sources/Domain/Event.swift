//
//  Event.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation

public struct Event: Hashable, Identifiable, Codable {
    public let id: UUID
    public let name: String?
    public let type: String?
    public let startDate: Date
    public let endDate: Date
    public let place: String?
    public let teamsUrl: URL?
    public let isRemoteClass: Bool
    public let isEventTransfer: Bool
    public let note: String?
    public let teacher: String?
    public let teacherProfileUrl: URL?
    public let facultyGroup: String?

    public init(
        id: UUID = UUID(),
        name: String? = nil,
        type: String? = nil,
        startDate: Date,
        endDate: Date,
        place: String? = nil,
        teamsUrl: URL? = nil,
        isRemoteClass: Bool,
        isEventTransfer: Bool,
        note: String? = nil,
        teacher: String? = nil,
        teacherProfileUrl: URL? = nil,
        facultyGroup: String? = nil
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.place = place
        self.teamsUrl = teamsUrl
        self.isRemoteClass = isRemoteClass
        self.isEventTransfer = isEventTransfer
        self.note = note
        self.teacher = teacher
        self.teacherProfileUrl = teacherProfileUrl
        self.facultyGroup = facultyGroup
    }

    public var typeDescription: String {
        let type = type ?? " "
        guard isEventTransfer else {
            return type
        }
        let note = note ?? " "
        return "\(type) \(note)"
    }

    public var `class`: FacultyGroupClass {
        FacultyGroupClass(name: name ?? "", type: type ?? "", teacher: teacher ?? "")
    }

    public var startDateWithoutTime: Date {
        Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate) ?? startDate
    }

    public var building: UekBuilding? {
        guard !isRemoteClass, let place else { return nil }
        let buildings = UekBuilding.allCases
        return buildings.first { building in
            guard let buildingCode = building.eventPlaceCode?.filter({ !$0.isWhitespace }).lowercased() else { return false }
            let placeCode = place.filter { !$0.isWhitespace }.lowercased()
            return placeCode.contains(buildingCode)
        }
    }
}
