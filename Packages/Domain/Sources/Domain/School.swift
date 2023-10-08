//
//  School.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 19/07/2023.
//

import Foundation

public struct School: Decodable {
    public let name: String
    public let city: String
    public let faculties: [Faculty]
    public let pavilions: [Pavilion]
    public let teacherGroups: [TeacherGroup]

    public var allGroupsWithoutLanguages: [FacultyGroup] {
        faculties
            .filter { !$0.name.hasPrefix("Centrum") }
            .flatMap { $0.groups }
    }

    public var languageGroups: [FacultyGroup] {
        faculties
            .filter { $0.name.hasPrefix("Centrum") }
            .flatMap { $0.groups }
    }
}
