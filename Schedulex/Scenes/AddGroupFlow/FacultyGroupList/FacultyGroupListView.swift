//
//  FacultyGroupListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

final class FacultyGroupListViewController: SwiftUIViewController<FacultyGroupListViewModel, FacultyGroupListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.faculty.name
    }
}

struct FacultyGroupListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: FacultyGroupListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.group, searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.facultyGroups) { facultyGroup in
                let caption = "\(facultyGroup.numberOfEvents) " + L10n.xEvents
                BaseListItem(title: facultyGroup.name, caption: caption)
                    .trailingIcon(.info)
                    .contentShape(Rectangle())
                    .onTapGesture { store.navigateToFacultyGroupDetails.send(facultyGroup) }
            }
        }
//        .baseListStyle(isEmpty: faculty.groups.isEmpty)
        .disableAutocorrection(true)
        .overlay { emptyState }
    }

    @ViewBuilder
    private var emptyState: some View {
        if !store.searchText.isEmpty && store.facultyGroups.isEmpty {
            EmptyStateView()
        }
    }
}

struct FacultyGroupsList_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupListView(store: FacultyGroupListStore())
    }
}
