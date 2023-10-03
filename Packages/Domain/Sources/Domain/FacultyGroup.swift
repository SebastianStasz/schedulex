//
//  FacultyGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct FacultyGroup: Identifiable, Hashable, Codable {
    public let name: String
    public let numberOfEvents: Int
    public let facultyDocument: String
    public let facultyUrl: String

    public var id: String { name }

    public init(name: String, numberOfEvents: Int, facultyDocument: String, facultyUrl: String) {
        self.name = name
        self.numberOfEvents = numberOfEvents
        self.facultyDocument = facultyDocument
        self.facultyUrl = facultyUrl
    }
}

public struct FacultyGroupDetails: Decodable {
    public let events: [Event]
    public let classes: [FacultyGroupClass]

    public init(events: [Event], classes: [FacultyGroupClass]) {
        self.events = events
        self.classes = classes
    }
}
