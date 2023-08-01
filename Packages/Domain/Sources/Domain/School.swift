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
}
