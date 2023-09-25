//
//  FacultyGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct FacultyGroup: Hashable, Codable {
    public let name: String
    public let numberOfEvents: Int
    public let facultyDocument: String
    public let facultyUrl: String

    public init(name: String, numberOfEvents: Int, facultyDocument: String, facultyUrl: String) {
        self.name = name
        self.numberOfEvents = numberOfEvents
        self.facultyDocument = facultyDocument
        self.facultyUrl = facultyUrl
    }
}

public struct FacultyGroupEvents: Decodable {
    public let events: [Event]

    public init(events: [Event]) {
        self.events = events
    }
}
