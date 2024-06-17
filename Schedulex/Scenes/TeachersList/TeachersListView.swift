//
//  TeachersListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 17/06/2024.
//

import SchedulexViewModel
import SwiftUI
import Widgets

struct TeachersListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: TeachersListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: "Teacher", searchText: $store.searchText, isFocused: $isSearchFocused)

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
        title = "Teachers"
    }
}

#Preview {
    TeachersListView(store: TeachersListStore())
}
