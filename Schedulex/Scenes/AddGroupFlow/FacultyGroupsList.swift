//
//  FacultyGroupsList.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Resources
import SwiftUI

struct FacultyGroupsList: View {
    @State private var facultyGroup: FacultyGroup?
    @State private var searchText = ""
    let faculty: Faculty

    var body: some View {
        List(filteredGroups) { group in
            let caption = "\(group.numberOfEvents) " + L10n.xEvents
            BaseListItem(title: group.name, caption: caption)
                .trailingIcon(.info) { facultyGroup = group }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Grupa")
        .sheet(item: $facultyGroup) { FacultyGroupDetailsView(facultyGroup: $0) }
        .baseListStyle(isEmpty: faculty.groups.isEmpty)
        .navigationTitle(faculty.name)
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
        FacultyGroupsList(faculty: .sample)
    }
}
