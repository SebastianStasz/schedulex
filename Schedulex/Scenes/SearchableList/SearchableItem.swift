//
//  SearchableItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 08/06/2024.
//

import Domain
import Resources

protocol SearchableItem: Identifiable {
    var name: String { get }
    var caption: String { get }

    static var searchPrompt: String { get }
}

extension Array where Element: SearchableItem {
    func filterUserSearch(text: String) -> Self {
        filterUserSearch(text: text, by: { $0.name })
    }
}

extension Faculty: SearchableItem {
    var caption: String {
        L10n.numberOfGroups + " \(numberOfGroups)"
    }

    static let searchPrompt = "L10n.facultyOrGroupPrompt"
}

extension Pavilion: SearchableItem {
    var caption: String {
        L10n.pavilionsListNumberOfClassrooms + " \(numberOfClassrooms)"
    }

    static let searchPrompt = L10n.pavilionsListSearchPrompt
}

extension Classroom: SearchableItem {
    var caption: String {
        L10n.numberOfEvents + " \(numberOfEvents)"
    }

    static let searchPrompt = L10n.classroomsListSearchPrompt
}

extension TeacherGroup: SearchableItem {
    var name: String { group }

    var caption: String {
        L10n.teacherGroupsListNumberOfTeachers + " \(numberOfTeachers)"
    }

    static let searchPrompt = L10n.teacherGroupsListSearchPrompt
}

extension Teacher: SearchableItem {
    var name: String { fullName }

    var caption: String {
        L10n.numberOfEvents + " \(numberOfEvents)"
    }

    static let searchPrompt = L10n.teacherListSearchPrompt
}
