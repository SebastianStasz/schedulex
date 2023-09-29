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
    let service: FirestoreService
    @State private var school: School?
    @State private var searchText = ""

    var body: some View {
        List {
            if school != nil {
                if searchText.isEmpty {
                    Section("For everyone") {
                        ForEach(globalSectionFaculties, content: facultyListRow)
                    }
                    Section("Faculties") {
                        ForEach(faculties, content: facultyListRow)
                    }
                    Section("Other") {
                        ForEach(facultyGroups, content: facultyGroupListRow)
                    }
                } else {
                    ForEach(faculties, content: facultyListRow)
                    ForEach(facultyGroups, content: facultyGroupListRow)
                }
            }
        }
        .task { school = try? await service.getCracowUniversityOfEconomics() }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Faculty or group")
        .overlay { loadingIndicatorOrEmptyState }
        .baseListStyle(isLoading: school == nil)
        .navigationTitle("UEK")
    }

    private func facultyListRow(faculty: Faculty) -> some View {
        NavigationLink(value: faculty) {
            BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) groups")
        }
    }

    private func facultyGroupListRow(group: FacultyGroup) -> some View {
        NavigationLink(value: group) {
            BaseListItem(title: group.name, caption: "\(group.numberOfEvents) events")
        }
    }

    @ViewBuilder
    private var loadingIndicatorOrEmptyState: some View {
         if isSearchEmpty {
            EmptyStateView()
        }
    }

    private var isSearchEmpty: Bool {
        !searchText.isEmpty && faculties.isEmpty && facultyGroups.isEmpty
    }

    private var globalSectionFaculties: [Faculty] {
        school?.faculties.filter { $0.type == .global }.sorted(by: { $0.name < $1.name }) ?? []
    }

    private var otherSectionFaculties: [Faculty] {
        school?.faculties.filter { $0.type == .other }.sorted(by: { $0.name < $1.name }) ?? []
    }

    private var faculties: [Faculty] {
        school?.faculties
            .filter { $0.type == .faculty }
            .filterUserSearch(text: searchText, by: { $0.name })
            .sorted(by: { $0.name < $1.name }) ?? []
    }

    private var facultyGroups: [FacultyGroup] {
        guard searchText.count > 1 else { return [] }
        return school?.faculties
            .flatMap { $0.groups }
            .filterUserSearch(text: searchText, by: { $0.name })
            .sorted(by: { $0.name < $1.name }) ?? []
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolView(service: FirestoreService())
    }
}
