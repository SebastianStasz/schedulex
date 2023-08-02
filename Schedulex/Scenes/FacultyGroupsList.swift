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
        List(filteredGroups, id: \.self) { group in
            NavigationLink(value: group) {
                BaseListItem(title: group.name, caption: "\(group.numberOfEvents) events")
            }
        }
        .navigationTitle(faculty.name)
        .searchable(text: $searchText)
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
