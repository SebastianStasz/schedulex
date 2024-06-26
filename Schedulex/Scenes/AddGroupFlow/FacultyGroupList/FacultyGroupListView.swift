//
//  FacultyGroupListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct FacultyGroupListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: FacultyGroupListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.group, searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.facultyGroups) { facultyGroup in
                BaseListRow(facultyGroup: facultyGroup)
                    .onTapGesture { store.navigateToFacultyGroupDetails.send(facultyGroup) }
            }
        }
        .disableAutocorrection(true)
        .baseListStyle(isEmpty: store.isListEmpty, isSearching: store.isSearching)
    }
}

final class FacultyGroupListViewController: SwiftUIViewController<FacultyGroupListViewModel, FacultyGroupListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.faculty.name
    }
}

struct FacultyGroupsList_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupListView(store: FacultyGroupListStore())
    }
}
