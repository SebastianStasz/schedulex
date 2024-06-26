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
    init<Item: SearchableItem>(item: Item) {
        title = item.name
        caption = item.caption
    }

    init(facultyGroup: FacultyGroup, trailingIcon: Icon = .chevronRight, iconColor: Color = .accentPrimary) {
        title = facultyGroup.name
        caption = L10n.numberOfEvents + " \(facultyGroup.numberOfEvents)"
        self.trailingIcon = trailingIcon
        self.iconColor = iconColor
    }
}

#Preview {
    BaseListRow(facultyGroup: .sample)
}
