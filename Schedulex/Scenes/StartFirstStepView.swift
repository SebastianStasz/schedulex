//
//  StartFirstStepView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Domain
import Resources
import SchedulexFirebase
import SwiftUI
import Widgets

struct StartFirstStepView: View {
    @EnvironmentObject private var service: FirestoreService
    @State private var selectedGroups: [FacultyGroup] = []
    @State private var searchText = ""
    @State private var school: School?

    @FocusState private var isEditing: Bool

    var body: some View {
        NavigationStack {
            SectionedList(sections) { sectionIndex, facultyGroup in
                let isSelected = selectedGroups.contains(facultyGroup)
                let icon: Icon = isSelected ? .checkmark : .circle
                let color: Color = isSelected ? .greenPrimary : .accentPrimary
                let select = { selectedGroups.append(facultyGroup) }
                let deselect = { selectedGroups.removeAll(where: { $0 == facultyGroup }) }

                FacultyGroupListRow(facultyGroup: facultyGroup, trailingIcon: icon, iconColor: color)
                    .onTapGesture { isSelected ? deselect() : select() }
            }
            .navigationTitle(L10n.startFirstStepTitle)
            .baseListStyle(isLoading: school == nil)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: L10n.startFirstStepPrompt)
            .textInputAutocapitalization(.characters)
            .autocorrectionDisabled()
            .toolbar { toolbarContent }
            .animation(.easeInOut(duration: 0.15), value: selectedGroups)
        }
        .task { school = try? await service.getCracowUniversityOfEconomics() }
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            TextButton(L10n.nextButton, action: {})
        }
    }

    private var sections: [ListSection<FacultyGroup>] {
        [ListSection(title: L10n.startFirstStepSelected, items: selectedGroups, emptyLabel: L10n.startFirstStepNoGroups, isLazy: false),
         ListSection(title: L10n.startFirstStepAllGroups, items: facultyGroups)]
    }

    private var facultyGroups: [FacultyGroup] {
        (school?.allGroupsWithoutLanguages ?? [])
            .filterUserSearch(text: searchText, by: { $0.name })
            .sorted(by: { $0.name < $1.name })
    }
}

#Preview {
    StartFirstStepView()
        .environmentObject(FirestoreService())
}
