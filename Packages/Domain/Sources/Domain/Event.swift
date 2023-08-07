//
//  Event.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation

public struct Event: Hashable, Decodable {
    public let startDate: Date?
    public let endDate: Date?
    public let name: String?
    public let place: String?
    public let teacher: String?
    public let type: String?

    public init(startDate: Date?, endDate: Date?, name: String?, place: String?, teacher: String?, type: String?) {
        self.startDate = startDate
        self.endDate = endDate
        self.name = name
        self.place = place
        self.teacher = teacher
        self.type = type
    }

    public var startDateWithoutTime: Date? {
        guard let startDate else { return nil }
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate)
    }
}
