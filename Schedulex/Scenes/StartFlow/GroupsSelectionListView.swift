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
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.startFirstStepPrompt, searchText: $searchText)
            
            ScrollViewReader { proxy in
                SectionedList(sections, pinnedHeaders: false) { sectionIndex, facultyGroup in
                    let isSelected = selectedGroups.contains(facultyGroup)
                    let icon: Icon = isSelected ? .checkmark : .circle
                    let color: Color = isSelected ? .greenPrimary : .accentPrimary
                    let select = { selectedGroups.append(facultyGroup) }
                    let deselect = { selectedGroups.removeAll(where: { $0 == facultyGroup }) }

                    FacultyGroupListRow(facultyGroup: facultyGroup, trailingIcon: icon, iconColor: color)
                        .onTapGesture { isSelected ? deselect() : select() }
                }
                .keyboardType(.alphabet)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.characters)
                .animation(.easeInOut(duration: 0.15), value: selectedGroups)
                .onAppear { proxy.scrollTo(0, anchor: .top) }
            }
        }
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
