//
//  EditableFacultyGroupClass.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import Foundation

public struct EditableFacultyGroupClass: Equatable, Hashable, Codable {
    public let facultyGroupName: String
    public let facultyGroupClass: FacultyGroupClass

    public func toFacultyGroupClass() -> FacultyGroupClass {
        FacultyGroupClass(name: facultyGroupClass.name, type: facultyGroupClass.type, teacher: facultyGroupClass.teacher)
    }
}

public extension FacultyGroupClass {
    func toEditableFacultyGroupClass(facultyGroupName: String) -> EditableFacultyGroupClass {
        EditableFacultyGroupClass(facultyGroupName: facultyGroupName, facultyGroupClass: self)
    }
}
