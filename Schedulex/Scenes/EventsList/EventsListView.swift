//
//  EventsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import SchedulexViewModel
import SwiftUI
import Widgets

struct EventsListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: EventsListStore

    var rootBody: some View {
        VStack(spacing: 0) {
            SearchField(prompt: "Search", searchText: $store.searchText, isFocused: $isSearchFocused)

            ScrollViewReader { _ in
                SectionedList(store.sections, pinnedHeaders: true, separatorHeight: .medium) { _, event in
                    EventCardView(event: event, color: store.color, currentDate: .now, isEventInProgress: false, isCancelled: false)
                }
            }
        }
        .baseListStyle(isEmpty: isEmpty, isLoading: store.isLoading.value)
    }

    private var isEmpty: Bool {
        store.sections.isEmpty && store.searchText.isEmpty
    }
}

final class EventsListViewController: SwiftUIViewController<EventsListViewModel, EventsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.input.title
    }
}

#Preview {
    EventsListView(store: EventsListStore(color: .blue))
}
