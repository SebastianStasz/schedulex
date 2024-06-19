//
//  BaseListRow.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct BaseListRow: View {
    let title: String
    let caption: String
    var trailingIcon: Icon = .chevronRight
    var iconColor: Color = .accentPrimary

    var body: some View {
        BaseListItem(title: title, caption: caption)
            .trailingIcon(trailingIcon, iconColor: iconColor, iconSize: 15)
            .contentShape(Rectangle())
    }
}

extension BaseListRow {
    init(faculty: Faculty) {
        title = faculty.name
        caption = L10n.numberOfGroups + " \(faculty.numberOfGroups)"
    }

    init(facultyGroup: FacultyGroup, trailingIcon: Icon = .chevronRight, iconColor: Color = .accentPrimary) {
        title = facultyGroup.name
        caption = L10n.numberOfEvents + " \(facultyGroup.numberOfEvents)"
        self.trailingIcon = trailingIcon
        self.iconColor = iconColor
    }

    init(pavilion: Pavilion) {
        title = pavilion.name
        caption = L10n.pavilionsListNumberOfClassrooms + " \(pavilion.numberOfClassrooms)"
    }

    init(classroom: Classroom) {
        title = classroom.name
        caption = L10n.numberOfEvents + " \(classroom.numberOfEvents)"
    }

    init(teacherGroup: TeacherGroup) {
        title = teacherGroup.group
        caption = L10n.teacherGroupsListNumberOfTeachers + " \(teacherGroup.numberOfTeachers)"
    }

    init(teacher: Teacher) {
        title = teacher.fullName
        caption = L10n.numberOfEvents + " \(teacher.numberOfEvents)"
    }
}

#Preview {
    BaseListRow(facultyGroup: .sample)
}
