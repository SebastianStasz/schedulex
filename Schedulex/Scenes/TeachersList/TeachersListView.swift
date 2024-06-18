//
//  TeachersListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 17/06/2024.
//

import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct TeachersListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: TeachersListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.teacherListSearchPrompt, searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.teachers) { teacher in
                BaseListRow(teacher: teacher)
                    .onTapGesture { store.navigateToEventsListView.send(teacher) }
            }
        }
    }
}

final class TeachersListViewController: SwiftUIViewController<TeachersListViewModel, TeachersListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.teachersListTitle
    }
}

#Preview {
    TeachersListView(store: TeachersListStore())
}
