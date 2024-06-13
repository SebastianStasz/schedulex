//
//  EventsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/06/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import UEKScraper
import UIKit
import Widgets

final class EventsListStore: RootStore {
    @Published var searchText = ""
    @Published fileprivate(set) var sections: [ListSection<Event>] = []

    let color: FacultyGroupColor
    let isLoading = DriverState(true)

    init(color: FacultyGroupColor) {
        self.color = color
    }
}

struct EventsListViewModel: ViewModel {
    var navigationController: UINavigationController?
    let input: EventsListInput

    func makeStore(context: Context) -> EventsListStore {
        let store = EventsListStore(color: input.color)
        let eventsPublisher = DriverSubject<[Event]>()

        CombineLatest(eventsPublisher, store.$searchText)
            .map { filterEvents($0, searchText: $1) }
            .map { makeSections(from: $0) }
            .assign(to: &store.$sections)

        switch input {
        case let .facultyGroup(_, events):
            eventsPublisher.send(events)

        case let .classroom(classroom):
            store.viewWillAppear
                .perform(isLoading: store.isLoading) {
                    try await UekScheduleService().getEvents(from: classroom.classroomUrl)
                }
                .sink { eventsPublisher.send($0) }
                .store(in: &store.cancellables)
        }

        return store
    }

    private func filterEvents(_ events: [Event], searchText: String) -> [Event] {
        searchText.isEmpty ? events : events.filter {
            let fields = [$0.type, $0.name, $0.place, $0.teacher]
            return fields.contains { $0?.containsCaseInsensitive(searchText) ?? false }
        }
    }

    private func makeSections(from events: [Event]) -> [ListSection<Event>] {
        Dictionary(grouping: events) { $0.startDateWithoutTime }
            .sorted { $0.key < $1.key }
            .map { ListSection(title: $0.formatted(style: .dateLong), items: $1) }
    }
}
