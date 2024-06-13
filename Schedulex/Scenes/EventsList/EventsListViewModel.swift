//
//  EventsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/06/2024.
//

import Domain
import UIKit
import Widgets
import SchedulexViewModel
import SchedulexCore
import UEKScraper

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

        eventsPublisher
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

    private func makeSections(from events: [Event]) -> [ListSection<Event>] {
        events
            .reduce(into: [ListSection<Event>]()) { result, event in
                let date = event.startDateWithoutTime.formatted(style: .dateLong)
                if let sectionIndex = result.firstIndex(where: { $0.title == date }) {
                    let items = result[sectionIndex].items
                    result.remove(at: sectionIndex)
                    result.append(ListSection(title: date, items: items + [event]))
                } else {
                    result.append(ListSection(title: date, items: [event]))
                }
            }
    }
}
