//
//  FacultyGroupDetails.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 12/10/2023.
//

import Foundation

public struct FacultyGroupDetails: Equatable {
    public let name: String
    public let events: [Event]
    public let classes: [FacultyGroupClass]

    public init(name: String, events: [Event], classes: [FacultyGroupClass]) {
        self.name = name
        self.events = events
        self.classes = classes
    }
}
