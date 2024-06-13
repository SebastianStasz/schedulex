//
//  EventsListInput.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/06/2024.
//

import Domain

enum EventsListInput {
    case facultyGroup(FacultyGroup, [Event])
    case classroom(Classroom)

    var title: String {
        switch self {
        case let .facultyGroup(facultyGroup, _):
            return facultyGroup.name
        case let .classroom(classroom):
            return classroom.name
        }
    }

    var color: FacultyGroupColor {
        switch self {
        case let .facultyGroup(facultyGroup, _):
            return facultyGroup.color
        case .classroom:
            return .blue
        }
    }
}
