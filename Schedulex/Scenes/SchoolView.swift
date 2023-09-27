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
                Section("For everyone") {
                    ForEach(globalSectionIFaculties, id: \.self) { faculty in
                        NavigationLink(value: faculty) {
                            BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) groups")
                        }
                    }
                }
                Section("Faculties") {
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
                Section("Other") {
                    ForEach(otherSectionFaculties, id: \.self) { faculty in
                        NavigationLink(value: faculty) {
                            BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) groups")
                        }
                    }
                }
            }
        }
        .task { school = try? await service.getCracowUniversityOfEconomics() }
        .searchable(text: $searchText, prompt: "Faculty or group")
        .overlay { loadingIndicatorOrEmptyState }
        .navigationTitle("UEK")
        .baseListStyle()
    }

    @ViewBuilder
    private var loadingIndicatorOrEmptyState: some View {
        if school == nil {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .progressViewStyle(.circular)
                .background(Color(uiColor: .systemGroupedBackground))
        } else if isSearchEmpty {
            EmptyStateView()
        }
    }

    private var isSearchEmpty: Bool {
        !searchText.isEmpty && faculties.isEmpty && facultyGroups.isEmpty
    }

    private var globalSectionIFaculties: [Faculty] {
        school?.faculties.filter { $0.type == .global } ?? []
    }

    private var otherSectionFaculties: [Faculty] {
        school?.faculties.filter { $0.type == .other } ?? []
    }

    private var faculties: [Faculty] {
        school?.faculties.filter { $0.type == .faculty }.filterUserSearch(text: searchText, by: { $0.name }) ?? []
    }

    private var facultyGroups: [FacultyGroup] {
        guard searchText.count > 1 else { return [] }
        return school?.faculties.flatMap { $0.groups }.filterUserSearch(text: searchText, by: { $0.name }) ?? []
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolView(service: FirestoreService())
    }
}
