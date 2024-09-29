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
    case teacher(Teacher)

    var omitLanguageClasses: Bool {
        switch self {
        case let .facultyGroup(facultyGroup):
            return !facultyGroup.isLanguage
        case .classroom, .teacher:
            return false
        }
    }

    func getPlace(cell4: String?, cell5: String?) -> String? {
        switch self {
        case .facultyGroup:
            return cell5?.nilIfEmpty()
        case let .classroom(classroom):
            return classroom.name
        case .teacher:
            return cell4?.nilIfEmpty()
        }
    }

    func getTeacher(from text: String?) -> String? {
        switch self {
        case .facultyGroup, .classroom:
            return text
        case let .teacher(teacher):
            return teacher.fullName
        }
    }

    func getFacultyGroup(from text: String?) -> String? {
        switch self {
        case let .facultyGroup(facultyGroup):
            return facultyGroup.name
        case .classroom, .teacher:
            return text
        }
    }
}
