//
//  ClassroomsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct ClassroomsListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: ClassroomsListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.classroomsListSearchPrompt, searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.classrooms) { classroom in
                BaseListRow(classroom: classroom)
                    .onTapGesture { store.navigateToEventsListView.send(classroom) }
            }
        }
    }
}

final class ClassroomsListViewController: SwiftUIViewController<ClassroomsListViewModel, ClassroomsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.pavilion.name
    }
}

#Preview {
    ClassroomsListView(store: ClassroomsListStore())
}
