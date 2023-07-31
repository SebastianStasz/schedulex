//
//  SchoolView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import SwiftUI
import SchedulexFirebase

struct SchoolView: View {
    @State private var searchText = ""
    @State private var school: School?

    var body: some View {
        List(faculties) { faculty in
            NavigationLink(destination: { FacultyGroupsList(groups: faculty.groups) }) {
                BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) groups")
            }
        }
        .navigationTitle("UEK")
        .searchable(text: $searchText)
        .task { school = try? await FirestoreService().getCracowUniversityOfEconomics() }
    }

    private var faculties: [Faculty] {
        school?.faculties.filterUserSearch(text: searchText, by: { $0.name }) ?? []
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolView()
    }
}
