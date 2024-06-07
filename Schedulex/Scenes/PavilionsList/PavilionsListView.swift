//
//  PavilionsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct PavilionsListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: PavilionsListStore

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: L10n.pavilionsListSearchPrompt, searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.pavilions) {
                BaseListRow(pavilion: $0)
            }
        }
        .baseListStyle(isLoading: store.isLoading.value)
    }
}

final class RoomsListViewController: SwiftUIViewController<PavilionsListViewModel, PavilionsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.pavilionsListTitle
    }
}

#Preview {
    PavilionsListView(store: PavilionsListStore())
}
