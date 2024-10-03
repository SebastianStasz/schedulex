//
//  EventsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct EventsListView: RootView {
    @State private var selectedEvent: Event?
    @State private var isSearchFocused = false
    @ObservedObject var store: EventsListStore

    var rootBody: some View {
        VStack(spacing: 0) {
            SearchField(prompt: L10n.classroomEventsListSearchPrompt, searchText: $store.searchText, isFocused: $isSearchFocused)

            ScrollViewReader { proxy in
                SectionedList(store.sections, pinnedHeaders: true, separatorHeight: .medium) { _, event in
                    EventCardView(event: event, color: store.color, currentDate: .now, isEventInProgress: false, isCancelled: false, displayType: store.eventDisplayType)
                        .onTapGesture { selectedEvent = event }
                }
                .onReceive(store.scrollToSection) {
                    proxy.scrollTo(store.sectionIndexToScroll, anchor: .top)
                }
                .onChange(of: store.sections) { _ in
                    proxy.scrollTo(store.sectionIndexToScroll, anchor: .top)
                }
            }
        }
        .baseListStyle(isEmpty: store.isListEmpty, isLoading: store.isLoading.value, isSearching: store.isSearching)
        .sheet(item: $selectedEvent) { EventDetailsView(event: $0, displayType: store.eventDisplayType, openMapWithBuilding: openCampusMap) }
    }

    private func openCampusMap(with building: UekBuilding) {
        selectedEvent = nil
        store.openMapWithBuilding(building)
    }
}

final class EventsListViewController: SwiftUIViewController<EventsListViewModel, EventsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.input.title
    }
}

#Preview {
    EventsListView(store: EventsListStore(color: .blue, eventDisplayType: .facultyGroup))
}
