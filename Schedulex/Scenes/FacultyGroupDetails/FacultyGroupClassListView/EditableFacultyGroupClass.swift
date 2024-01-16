//
//  EditableFacultyGroupClass.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import Foundation

struct EditableFacultyGroupClass: Equatable, Hashable, Codable {
    let facultyGroupName: String
    let facultyGroupClass: FacultyGroupClass

    func toFacultyGroupClass() -> FacultyGroupClass {
        FacultyGroupClass(name: facultyGroupClass.name, type: facultyGroupClass.type, teacher: facultyGroupClass.teacher)
    }
}

extension FacultyGroupClass {
    func toEditableFacultyGroupClass(facultyGroupName: String) -> EditableFacultyGroupClass {
        EditableFacultyGroupClass(facultyGroupName: facultyGroupName, facultyGroupClass: self)
    }
}
