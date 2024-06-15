//
//  EventsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import SchedulexViewModel
import SwiftUI
import Widgets

struct EventsListView: RootView {
    @State private var selectedEvent: Event?
    @State private var isSearchFocused = false
    @ObservedObject var store: EventsListStore

    var rootBody: some View {
        VStack(spacing: 0) {
            SearchField(prompt: "Search", searchText: $store.searchText, isFocused: $isSearchFocused)

            ScrollViewReader { proxy in
                SectionedList(store.sections, pinnedHeaders: true, separatorHeight: .medium) { sectionIndex, event in
                    EventCardView(event: event, color: store.color, currentDate: .now, isEventInProgress: false, isCancelled: false, isForFacultyGroup: false)
                        .onTapGesture { selectedEvent = event }
                }
                .onChange(of: store.sections) { _ in
                    proxy.scrollTo(store.sectionIndexToScroll, anchor: .top)
                }
            }
        }
        .baseListStyle(isEmpty: isEmpty, isLoading: store.isLoading.value)
        .sheet(item: $selectedEvent) { EventDetailsView(event: $0) }
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
