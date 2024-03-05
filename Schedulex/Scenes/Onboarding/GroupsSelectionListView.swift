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
    let emptyMessage: String
    var bottomInset: CGFloat = 0
    @Binding var isSearchFocused: Bool
    @Binding var selectedGroups: [FacultyGroup]

    var body: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.startFirstStepPrompt, searchText: $searchText, isFocused: $isSearchFocused)

            ScrollViewReader { proxy in
                SectionedList(sections, bottomInset: bottomInset) { sectionIndex, facultyGroup in
                    let isSelected = selectedGroups.contains(facultyGroup)
                    let icon: Icon = isSelected ? .checkmark : .circle
                    let color: Color = isSelected ? .greenPrimary : .accentPrimary
                    let select = { selectedGroups.append(facultyGroup) }
                    let deselect = { selectedGroups.removeAll(where: { $0 == facultyGroup }) }

                    FacultyGroupListRow(facultyGroup: facultyGroup, trailingIcon: icon, iconColor: color)
                        .onTapGesture { isSelected ? deselect() : select() }
                }
                .animation(.easeInOut(duration: 0.15), value: selectedGroups)
                .onAppear {
                    proxy.scrollTo(0, anchor: .top)
                    isSearchFocused = !groups.isEmpty
                }
                .onChange(of: searchText) { _ in
                    proxy.scrollTo(0, anchor: .top)
                }
            }
        }
        .padding(.top, .small)
        .baseListStyle(isLoading: groups.isEmpty)
        .onDisappear { isSearchFocused = false }
        .onChange(of: groups) { isSearchFocused = !$0.isEmpty }
    }

    private var sections: [ListSection<FacultyGroup>] {
        [ListSection(title: L10n.startFirstStepSelected, items: selectedGroups, emptyLabel: emptyMessage),
         ListSection(title: L10n.startFirstStepAllGroups, items: availableGroups, emptyLabel: L10n.noResultMessage, isLazy: true)]
    }

    private var availableGroups: [FacultyGroup] {
        groups.filterByNameAndSort(text: searchText)
    }
}

#Preview {
    GroupsSelectionListView(groups: [], emptyMessage: "Empty message", isSearchFocused: .constant(true), selectedGroups: .constant([]))
}
