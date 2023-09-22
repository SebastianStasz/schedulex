//
//  SchoolView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Domain
import SchedulexFirebase
import SwiftUI
import Widgets

struct SchoolView: View {
    @State private var school: School?
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
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
            .navigationDestination(for: Faculty.self) {
                FacultyGroupsList(faculty: $0)
            }
            .navigationDestination(for: FacultyGroup.self) {
                FacultyGroupView(facultyGroup: $0)
            }
            .searchable(text: $searchText, prompt: "Faculty or group")
            .navigationTitle("UEK")
            .baseListStyle()
            .closeButton()
        }
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
