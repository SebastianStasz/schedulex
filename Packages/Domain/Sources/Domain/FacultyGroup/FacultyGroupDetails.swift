//
//  FacultyGroupDetails.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 12/10/2023.
//

import Foundation

public struct FacultyGroupDetails: Equatable {
    public let facultyGroup: FacultyGroup
    public let isHidden: Bool
    public let events: [Event]
    public let classes: [FacultyGroupClass]

    public var name: String {
        facultyGroup.name
    }

    public var color: FacultyGroupColor {
        facultyGroup.color
    }

    public init(facultyGroup: FacultyGroup, isHidden: Bool, events: [Event], classes: [FacultyGroupClass]) {
        self.facultyGroup = facultyGroup
        self.isHidden = isHidden
        self.events = events
        self.classes = classes
    }
}
