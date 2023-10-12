//
//  FacultyGroupDetails.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 12/10/2023.
//

import Foundation

public struct FacultyGroupDetails: Decodable {
    public let events: [Event]
    public let classes: [FacultyGroupClass]

    public init(events: [Event], classes: [FacultyGroupClass]) {
        self.events = events
        self.classes = classes
    }
}
