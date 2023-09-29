//
//  FacultyGroupsList.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import SwiftUI

struct FacultyGroupsList: View {
    @State private var searchText = ""
    let faculty: Faculty

    var body: some View {
        List(filteredGroups) { group in
            NavigationLink(value: group) {
                BaseListItem(title: group.name, caption: "\(group.numberOfEvents) events")
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Grupa")
        .navigationTitle(faculty.name)
        .overlay { emptyState }
        .baseListStyle(isEmpty: faculty.groups.isEmpty)
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
