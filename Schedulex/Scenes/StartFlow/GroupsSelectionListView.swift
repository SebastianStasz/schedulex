//
//  GroupsSelectionListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Domain
import SwiftUI
import Resources
import Widgets

struct GroupsSelectionListView: View {
    @State private var searchText = ""

    let groups: [FacultyGroup]
    @Binding var selectedGroups: [FacultyGroup]

    var body: some View {
        SectionedList(sections) { sectionIndex, facultyGroup in
            let isSelected = selectedGroups.contains(facultyGroup)
            let icon: Icon = isSelected ? .checkmark : .circle
            let color: Color = isSelected ? .greenPrimary : .accentPrimary
            let select = { selectedGroups.append(facultyGroup) }
            let deselect = { selectedGroups.removeAll(where: { $0 == facultyGroup }) }

            FacultyGroupListRow(facultyGroup: facultyGroup, trailingIcon: icon, iconColor: color)
                .onTapGesture { isSelected ? deselect() : select() }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: L10n.startFirstStepPrompt)
        .textInputAutocapitalization(.characters)
        .autocorrectionDisabled()
        .keyboardType(.alphabet)
        .animation(.easeInOut(duration: 0.15), value: selectedGroups)
    }


    private var sections: [ListSection<FacultyGroup>] {
        [ListSection(title: L10n.startFirstStepSelected, items: selectedGroups, emptyLabel: L10n.startFirstStepNoGroups, isLazy: false),
         ListSection(title: L10n.startFirstStepAllGroups, items: availableGroups)]
    }

    private var availableGroups: [FacultyGroup] {
        groups
            .filterUserSearch(text: searchText, by: { $0.name })
            .sorted(by: { $0.name < $1.name })
    }
}

#Preview {
    GroupsSelectionListView(groups: [], selectedGroups: .constant([]))
}
