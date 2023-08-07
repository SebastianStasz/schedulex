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
        List {
            ForEach(faculties, id: \.self) { faculty in
                NavigationLink(value: faculty) {
                    BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) groups")
                }
            }
            ForEach(facultyGroups, id: \.self) { group in
                NavigationLink(value: group) {
                    BaseListItem(title: group.name, caption: "\(group.numberOfEvents) events")
                }
            }
        }
        .navigationTitle("UEK")
        .searchable(text: $searchText, prompt: "Faculty or group")
        .task { school = try? await FirestoreService().getCracowUniversityOfEconomics() }
    }

    private var faculties: [Faculty] {
        school?.faculties.filterUserSearch(text: searchText, by: { $0.name }) ?? []
    }

    private var facultyGroups: [FacultyGroup] {
        guard searchText.count > 1 else { return [] }
        return school?.faculties.flatMap { $0.groups }.filterUserSearch(text: searchText, by: { $0.name }) ?? []
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolView()
    }
}
