//
//  Event.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation

public struct Event: Hashable, Identifiable {
    public let facultyGroupName: String
    public let facultyGroupColor: FacultyGroupColor
    public let isEventTransfer: Bool
    public let isRemoteClass: Bool
    public let eventTransferNote: String?
    public let startDate: Date?
    public let endDate: Date?
    public let name: String?
    public let place: String?
    public let teacher: String?
    public let teacherProfileUrl: URL?
    public let teamsUrl: URL?
    public let type: String?

    public var id: Int {
        hashValue
    }

    public init(facultyGroupName: String,
                facultyGroupColor: FacultyGroupColor,
                isEventTransfer: Bool,
                isRemoteClass: Bool,
                eventTransferNote: String?,
                startDate: Date?,
                endDate: Date?,
                name: String?,
                place: String?,
                teacher: String?,
                teacherProfileUrl: URL?,
                teamsUrl: URL?,
                type: String?)
    {
        self.facultyGroupName = facultyGroupName
        self.facultyGroupColor = facultyGroupColor
        self.isEventTransfer = isEventTransfer
        self.isRemoteClass = isRemoteClass
        self.eventTransferNote = eventTransferNote
        self.startDate = startDate
        self.endDate = endDate
        self.name = name
        self.place = place
        self.teacher = teacher
        self.teacherProfileUrl = teacherProfileUrl
        self.teamsUrl = teamsUrl
        self.type = type
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

    public var startDateWithoutTime: Date? {
        guard let startDate else { return nil }
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate)
    }
}
