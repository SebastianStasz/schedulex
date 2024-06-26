//
//  SearchableListStore.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 26/06/2024.
//

import Foundation
import SchedulexViewModel

final class SearchableListStore<Item: SearchableItem>: RootStore {
    @Published var items: [Item] = []
    @Published var searchText = ""

    var isListEmpty: Bool { items.isEmpty }
    var isSearching: Bool { !searchText.isEmpty }

    let isLoading = DriverState(false)
    let onSelectListItem = DriverSubject<Item>()
}
