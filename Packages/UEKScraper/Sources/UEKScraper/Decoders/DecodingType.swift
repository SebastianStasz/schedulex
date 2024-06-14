//
//  DecodingType.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 14/06/2024.
//

import Domain

enum DecodingType {
    case facultyGroup(FacultyGroup)
    case classroom(Classroom)

    var omitLanguageClasses: Bool {
        switch self {
        case let .facultyGroup(facultyGroup):
            return !facultyGroup.isLanguage
        case .classroom:
            return false
        }
    }

    func getPlace(from text: String?) -> String? {
        switch self {
        case .facultyGroup:
            return text
        case let .classroom(classroom):
            return classroom.name
        }
    }

    func getFacultyGroup(from text: String?) -> String? {
        switch self {
        case let .facultyGroup(facultyGroup):
            return facultyGroup.name
        case .classroom:
            return text
        }
    }
}
