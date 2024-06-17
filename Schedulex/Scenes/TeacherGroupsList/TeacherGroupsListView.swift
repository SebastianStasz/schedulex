//
//  TeacherGroupsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 16/06/2024.
//

import SchedulexViewModel
import SwiftUI
import Widgets

struct TeacherGroupsListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: TeacherGroupsListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: "Teacher group", searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.teacherGroups) { teacherGroup in
                BaseListRow(teacherGroup: teacherGroup)
                    .onTapGesture { store.navigateToTeachersList.send(teacherGroup) }
            }
        }
        .baseListStyle(isLoading: store.isLoading.value)
    }
}

final class TeacherGroupsListViewController: SwiftUIViewController<TeacherGroupsListViewModel, TeacherGroupsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teacher groups"
    }
}

#Preview {
    TeacherGroupsListView(store: TeacherGroupsListStore())
}
