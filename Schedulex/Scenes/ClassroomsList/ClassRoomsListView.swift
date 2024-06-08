//
//  ClassRoomsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct ClassRoomsListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: ClassRoomsListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.classroomsListSearchPrompt, searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.classrooms) {
                BaseListRow(classroom: $0)
            }
        }
    }
}

final class ClassRoomsListViewController: SwiftUIViewController<ClassRoomsListViewModel, ClassRoomsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.pavilion.name
    }
}

#Preview {
    ClassRoomsListView(store: ClassRoomsListStore())
}
