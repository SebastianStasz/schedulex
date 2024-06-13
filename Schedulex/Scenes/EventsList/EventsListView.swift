//
//  EventsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import SwiftUI
import Widgets
import SchedulexViewModel

struct EventsListView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: EventsListStore

    var rootBody: some View {
        VStack(spacing: 0) {
            SearchField(prompt: "Search", searchText: $store.searchText, isFocused: $isSearchFocused)

            ScrollViewReader { proxy in
                SectionedList(store.sections, pinnedHeaders: true, separatorHeight: .medium) { _, event in
                    EventCardView(event: event, color: store.color, currentDate: .now, isEventInProgress: false, isCancelled: false)
                }
            }
        }
        .baseListStyle(isEmpty: store.sections.isEmpty, isLoading: store.isLoading.value)
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
