//
//  FacultiesListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Domain
import Resources
import SchedulexFirebase
import SwiftUI
import Widgets

struct FacultiesListView: View {
    let service: FirestoreService
    @State private var school: School?
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                if school != nil {
                    if searchText.isEmpty {
                        Section(L10n.forEveryoneHeader) {
                            ForEach(globalSectionFaculties, content: facultyListRow)
                        }
                        Section(L10n.faculties) {
                            ForEach(faculties, content: facultyListRow)
                        }
                        Section(L10n.otherHeader) {
                            ForEach(otherSectionFaculties, content: facultyListRow)
                        }
                    } else {
                        ForEach(faculties, content: facultyListRow)
                        ForEach(facultyGroups) {
                            FacultyGroupListItem(facultyGroup: $0)
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: L10n.facultyOrGroupPrompt)
            .overlay { loadingIndicatorOrEmptyState }
            .baseListStyle(isLoading: school == nil)
            .navigationTitle(L10n.addGroup)
            .closeButton()
        }
        .task { school = try? await service.getCracowUniversityOfEconomics() }
    }

    private func facultyListRow(faculty: Faculty) -> some View {
        NavigationLink(destination: { FacultyGroupListView(faculty: faculty) }) {
            BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) " + L10n.xGroups)
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
        FacultiesListView(service: FirestoreService())
    }
}
