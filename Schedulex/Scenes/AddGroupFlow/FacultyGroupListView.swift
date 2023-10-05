//
//  FacultyGroupListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct FacultyGroupListView: View {
    @State private var searchText = ""
    @State private var facultyGroup: FacultyGroup?
    let faculty: Faculty

    var body: some View {
        BaseList(filteredGroups) { facultyGroup in
            let caption = "\(facultyGroup.numberOfEvents) " + L10n.xEvents
            BaseListItem(title: facultyGroup.name, caption: caption)
                .trailingIcon(.info)
                .contentShape(Rectangle())
                .onTapGesture { self.facultyGroup = facultyGroup }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: L10n.group)
        .sheet(item: $facultyGroup) { FacultyGroupDetailsView(facultyGroup: $0, type: .preview) }
        .baseListStyle(isEmpty: faculty.groups.isEmpty)
        .navigationTitle(faculty.name)
        .disableAutocorrection(true)
        .overlay { emptyState }
    }

    @ViewBuilder
    private var emptyState: some View {
        if !searchText.isEmpty && filteredGroups.isEmpty {
            EmptyStateView()
        }
    }

    private var filteredGroups: [FacultyGroup] {
        faculty.groups.filterUserSearch(text: searchText, by: { $0.name })
    }
}

struct FacultyGroupsList_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupListView(faculty: .sample)
    }
}
