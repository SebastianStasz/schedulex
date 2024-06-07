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
        caption = "\(faculty.numberOfGroups) " + L10n.xGroups
    }

    init(facultyGroup: FacultyGroup, trailingIcon _: Icon = .chevronRight, iconColor _: Color = .accentPrimary) {
        title = facultyGroup.name
        caption = "\(facultyGroup.numberOfEvents) " + L10n.xEvents
    }

    init(pavilion: Pavilion) {
        title = pavilion.pavilion
        let numberOfClassrooms = pavilion.numberOfClassrooms
        let captionSuffix = numberOfClassrooms > 1 ? L10n.pavilionsListClassrooms : L10n.pavilionsListClassroom
        caption = "\(numberOfClassrooms) " + captionSuffix
    }
}

#Preview {
    BaseListRow(facultyGroup: .sample)
}
