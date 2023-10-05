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
    @State private var facultyGroup: FacultyGroup?

    var body: some View {
        NavigationStack {
            Group {
                if searchText.isEmpty {
                    SectionedList(sections) { _, faculty in
                        facultyListRow(faculty: faculty)
                    }
                } else {
                    BaseList {
                        ForEach(faculties) {
                            facultyListRow(faculty: $0)

                            Separator()
                                .displayIf(faculties.last != $0 || (faculties.last == $0 && !facultyGroups.isEmpty))
                        }
                        ForEach(facultyGroups) { facultyGroup in
                            let caption = "\(facultyGroup.numberOfEvents) " + L10n.xEvents
                            BaseListItem(title: facultyGroup.name, caption: caption)
                                .trailingIcon(.info)
                                .contentShape(Rectangle())
                                .onTapGesture { self.facultyGroup = facultyGroup }

                            Separator()
                                .displayIf(facultyGroups.last != facultyGroup)
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: L10n.facultyOrGroupPrompt)
            .sheet(item: $facultyGroup) { FacultyGroupDetailsView(facultyGroup: $0, type: .preview) }
            .overlay { loadingIndicatorOrEmptyState }
            .baseListStyle(isLoading: school == nil)
            .navigationTitle(L10n.addGroup)
            .disableAutocorrection(true)
            .closeButton()
        }
        .task { school = try? await service.getCracowUniversityOfEconomics() }
    }

    private func facultyListRow(faculty: Faculty) -> some View {
        NavigationLink(destination: { FacultyGroupListView(faculty: faculty) }) {
            BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) " + L10n.xGroups)
                .trailingIcon(.chevronRight, iconSize: 15)
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

    private var sections: [ListSection<Faculty>] {
        [ListSection(title: L10n.forEveryoneHeader, items: getFaculties(ofType: .global)),
         ListSection(title: L10n.faculties, items: getFaculties(ofType: .faculty)),
         ListSection(title: L10n.otherHeader, items: getFaculties(ofType: .other))]
    }

    private func getFaculties(ofType type: FacultyType) -> [Faculty] {
        school?.faculties.filter { $0.type == type }.sorted(by: { $0.name < $1.name }) ?? []
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
