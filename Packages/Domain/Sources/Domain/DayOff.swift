//
//  DayOff.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 03/04/2024.
//

import Foundation

public struct DayOff: Codable {
    public let date: Date
    public let startTime: Date?
    public let endTime: Date?

    public init(date: Date, startTime: Date?, endTime: Date?) {
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
    }

    public var isWholeDay: Bool {
        startTime == nil || endTime == nil
    }
}
