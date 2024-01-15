//
//  FacultyGroupListRow.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct FacultyGroupListRow: View {
    let facultyGroup: FacultyGroup
    let trailingIcon: Icon
    let iconColor: Color

    var body: some View {
        BaseListItem(title: facultyGroup.name, caption: caption)
            .trailingIcon(trailingIcon, iconColor: iconColor, iconSize: 15)
            .contentShape(Rectangle())
    }

    private var caption: String {
        "\(facultyGroup.numberOfEvents) " + L10n.xEvents
    }
}

#Preview {
    FacultyGroupListRow(facultyGroup: .sample, trailingIcon: .info, iconColor: .accentPrimary)
}
