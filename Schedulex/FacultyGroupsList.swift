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
    let groups: [FacultyGroup]

    var body: some View {
        List(filteredGroups) {
            BaseListItem(title: $0.name)
        }
        .navigationTitle("Groups")
        .searchable(text: $searchText)
    }

    private var filteredGroups: [FacultyGroup] {
        groups.filterUserSearch(text: searchText, by: { $0.name })
    }
}

struct FacultyGroupsList_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupsList(groups: [])
    }
}
