//
//  FacultyGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct FacultyGroup: Hashable, Decodable {
    public let name: String
    public let facultyDocument: String
    public let numberOfEvents: Int

    public init(name: String, facultyDocument: String, numberOfEvents: Int) {
        self.name = name
        self.facultyDocument = facultyDocument
        self.numberOfEvents = numberOfEvents
    }
}

public struct FacultyGroupEvents: Decodable {
    public let events: [Event]

    public init(events: [Event]) {
        self.events = events
    }
}
