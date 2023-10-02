//
//  FacultyGroupListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Resources
import SwiftUI

struct FacultyGroupListView: View {
    @State private var searchText = ""
    let faculty: Faculty

    var body: some View {
        List(filteredGroups) {
            FacultyGroupListItem(facultyGroup: $0)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: L10n.group)
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
        FacultyGroupListView(faculty: .sample)
    }
}
