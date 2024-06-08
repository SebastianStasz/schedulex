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

    init(facultyGroup: FacultyGroup, trailingIcon _: Icon = .chevronRight, iconColor _: Color = .accentPrimary) {
        title = facultyGroup.name
        caption = L10n.numberOfEvents + " \(facultyGroup.numberOfEvents)"
    }

    init(pavilion: Pavilion) {
        title = pavilion.name
        caption = L10n.pavilionsListNumberOfClassrooms + " \(pavilion.numberOfClassrooms)"
    }

    init(classroom: Classroom) {
        title = classroom.name
        caption = ""
    }
}

#Preview {
    BaseListRow(facultyGroup: .sample)
}
