//
//  Event.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation

public struct Event: Hashable, Identifiable {
    public let id = UUID()
    public let name: String?
    public let type: String?
    public let startDate: Date
    public let endDate: Date
    public let place: String?
    public let teamsUrl: URL?
    public let isRemoteClass: Bool
    public let isEventTransfer: Bool
    public let eventTransferNote: String?
    public let teacher: String?
    public let teacherProfileUrl: URL?
    public let facultyGroup: String?

    public init(
        name: String? = nil,
        type: String? = nil,
        startDate: Date,
        endDate: Date,
        place: String? = nil,
        teamsUrl: URL? = nil,
        isRemoteClass: Bool,
        isEventTransfer: Bool,
        eventTransferNote: String? = nil,
        teacher: String? = nil,
        teacherProfileUrl: URL? = nil,
        facultyGroup: String? = nil
    ) {
        self.name = name
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.place = place
        self.teamsUrl = teamsUrl
        self.isRemoteClass = isRemoteClass
        self.isEventTransfer = isEventTransfer
        self.eventTransferNote = eventTransferNote
        self.teacher = teacher
        self.teacherProfileUrl = teacherProfileUrl
        self.facultyGroup = facultyGroup
    }

    public var typeDescription: String {
        let type = type ?? " "
        guard isEventTransfer else {
            return type
        }
        let note = eventTransferNote ?? " "
        return "\(type) \(note)"
    }

    public var `class`: FacultyGroupClass {
        FacultyGroupClass(name: name ?? "", type: type ?? "", teacher: teacher ?? "")
    }

    public var startDateWithoutTime: Date {
        Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate) ?? startDate
    }
}
