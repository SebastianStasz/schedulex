//
//  Event.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation
import Resources

public struct Event: Hashable {
    public let facultyGroupName: String
    public let facultyGroupColor: FacultyGroupColor
    public let isEventTransfer: Bool
    public let eventTransferNote: String?
    public let startDate: Date?
    public let endDate: Date?
    public let name: String?
    public let place: String?
    public let teacher: String?
    public let type: String?

    public init(facultyGroupName: String, facultyGroupColor: FacultyGroupColor, isEventTransfer: Bool, eventTransferNote: String?, startDate: Date?, endDate: Date?, name: String?, place: String?, teacher: String?, type: String?) {
        self.facultyGroupName = facultyGroupName
        self.facultyGroupColor = facultyGroupColor
        self.isEventTransfer = isEventTransfer
        self.eventTransferNote = eventTransferNote
        self.startDate = startDate
        self.endDate = endDate
        self.name = name
        self.place = place
        self.teacher = teacher
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

    public var status: String? {
        guard let startDate = startDate, let endDate = endDate else { return nil }
        if endDate <= .now {
            return nil
        } else {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            let isBeforeEvent = startDate > .now
            let date = isBeforeEvent ? startDate : endDate
            let prefix = isBeforeEvent ? "" : "\(L10n.eventFinishingIn) "
            let description = formatter.localizedString(for: date, relativeTo: .now)
            return prefix + description
        }
    }

    public var `class`: FacultyGroupClass {
        FacultyGroupClass(name: name ?? "", type: type ?? "", teacher: teacher ?? "")
    }

    public var startDateWithoutTime: Date? {
        guard let startDate else { return nil }
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate)
    }
}
