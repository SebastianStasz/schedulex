//
//  FacultyGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct FacultyGroup: Hashable, Decodable {
    public let name: String
    public let events: [Event]
    public let numberOfEvents: Int

    public init(name: String, events: [Event], numberOfEvents: Int) {
        self.name = name
        self.events = events
        self.numberOfEvents = numberOfEvents
    }
}
