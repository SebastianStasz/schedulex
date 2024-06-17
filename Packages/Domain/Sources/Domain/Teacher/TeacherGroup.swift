//
//  TeacherGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct TeacherGroup: Decodable, Identifiable {
    public let group: String
    public let teachers: [Teacher]

    public var id: String { group }

    public var numberOfTeachers: Int {
        teachers.count
    }
}
