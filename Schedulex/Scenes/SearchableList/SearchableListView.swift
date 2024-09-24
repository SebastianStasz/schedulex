//
//  SearchableListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 26/06/2024.
//

import Domain
import SchedulexViewModel
import SwiftUI
import Widgets

struct SearchableListView<Item: SearchableItem>: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: SearchableListStore<Item>

    var rootBody: some View {
        VStack(spacing: .medium) {
            SearchField(prompt: Item.searchPrompt, searchText: $store.searchText, isFocused: $isSearchFocused)

            BaseList(store.items) { item in
                NavigationRow(item: item) { store.onSelectListItem.send(item) }
            }
        }
        .baseListStyle(isEmpty: store.isListEmpty, isLoading: store.isLoading.value, isSearching: store.isSearching)
    }
}

#Preview {
    SearchableListView(store: SearchableListStore<Teacher>())
}
