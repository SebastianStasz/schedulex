//
//  FacultiesListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Domain
import Resources
import SchedulexFirebase
import SchedulexViewModel
import SwiftUI
import Widgets

struct FacultiesListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: FacultiesListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.facultyOrGroupPrompt, searchText: $store.searchText, isFocused: $isSearchFocused)

            Group {
                if store.searchText.isEmpty {
                    SectionedList(sections) { _, faculty in
                        facultyListRow(faculty: faculty)
                    }
                } else {
                    BaseList {
                        ForEach(getFaculties(ofType: .faculty)) {
                            facultyListRow(faculty: $0)

                            Separator()
                                .displayIf(store.faculties.last != $0 || (store.faculties.last == $0 && !store.facultyGroups.isEmpty))
                        }
                        ForEach(store.facultyGroups) { facultyGroup in
                            NavigationRow(facultyGroup: facultyGroup) { store.navigateToFacultyGroupDetails.send(facultyGroup) }

                            Separator()
                                .displayIf(store.facultyGroups.last != facultyGroup)
                        }
                    }
                }
            }
        }
        .baseListStyle(isLoading: store.isLoading.value, isSearching: !store.searchText.isEmpty)
        .disableAutocorrection(true)
    }

    private func facultyListRow(faculty: Faculty) -> some View {
        NavigationRow(item: faculty) { store.navigateToFacultyGroupList.send(faculty) }
    }

    private var sections: [ListSection<Faculty>] {
        [ListSection(title: L10n.forEveryoneHeader, items: getFaculties(ofType: .global)),
         ListSection(title: L10n.faculties, items: getFaculties(ofType: .faculty)),
         ListSection(title: L10n.otherHeader, items: getFaculties(ofType: .other))]
    }

    private func getFaculties(ofType type: FacultyType) -> [Faculty] {
        store.faculties.filter { $0.type == type }.sorted(by: { $0.name < $1.name })
    }
}

final class FacultiesListViewController: SwiftUIViewController<FacultiesListViewModel, FacultiesListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.addGroup
        addCloseButton()
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        FacultiesListView(store: FacultiesListStore())
    }
}
