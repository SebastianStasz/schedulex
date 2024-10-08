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
    @Published fileprivate(set) var sectionIndexToScroll: Int?
    @Published fileprivate(set) var sections: [ListSection<Event>] = []

    var isListEmpty: Bool { sections.isEmpty }
    var isSearching: Bool { !searchText.isEmpty }

    let color: FacultyGroupColor
    let isLoading = DriverState(false)
    let scrollToSection = DriverSubject<Void>()
    let eventDisplayType: EventDisplayType

    var openMapWithBuilding: (UekBuilding) -> Void = { _ in }

    init(color: FacultyGroupColor, eventDisplayType: EventDisplayType) {
        self.color = color
        self.eventDisplayType = eventDisplayType
    }
}

struct EventsListViewModel: ViewModel {
    var navigationController: UINavigationController?
    let input: EventsListInput

    func makeStore(context: Context) -> EventsListStore {
        let store = EventsListStore(color: input.color, eventDisplayType: input.eventDisplayType)
        let eventsPublisher = DriverSubject<[Event]>()
        var scrollToSectionOnViewDidAppear = false

        CombineLatest(eventsPublisher, store.$searchText)
            .map { filterAndGroupByDate(events: $0, searchText: $1) }
            .sink(on: store) {
                $0.sectionIndexToScroll = getClosestSectionIndexByTodaysDate(eventsByDate: $1)
                $0.sections = mapToListSections(eventsByDate: $1)
            }

        store.viewDidAppearForTheFirstTime
            .filter { scrollToSectionOnViewDidAppear }
            .sink(on: store) { $0.scrollToSection.send() }

        store.openMapWithBuilding = {
            pushCampusMapView(with: $0)
        }

        switch input {
        case let .facultyGroup(_, events):
            scrollToSectionOnViewDidAppear = true
            eventsPublisher.send(events)

        case let .classroom(classroom):
            store.viewWillAppear
                .perform(isLoading: store.isLoading) {
                    try await UekScheduleService().getEvents(for: classroom)
                }
                .sink { eventsPublisher.send($0) }
                .store(in: &store.cancellables)

        case let .teacher(teacher):
            store.viewWillAppear
                .perform(isLoading: store.isLoading) {
                    try await UekScheduleService().getEvents(for: teacher)
                }
                .sink { eventsPublisher.send($0) }
                .store(in: &store.cancellables)
        }

        return store
    }

    private func filterAndGroupByDate(events: [Event], searchText: String) -> [(Date, [Event])] {
        let events = filterEvents(events, searchText: searchText)
        return Dictionary(grouping: events) { $0.startDateWithoutTime }.sorted { $0.key < $1.key }
    }

    private func mapToListSections(eventsByDate: [(Date, [Event])]) -> [ListSection<Event>] {
        eventsByDate.map { ListSection(title: $0.formatted(style: .dateLong), items: $1) }
    }

    private func filterEvents(_ events: [Event], searchText: String) -> [Event] {
        searchText.isEmpty ? events : events.filter {
            let fields = [$0.type, $0.name, $0.place, $0.teacher]
            return fields.contains { $0?.containsCaseInsensitive(searchText) ?? false }
        }
    }

    private func getClosestSectionIndexByTodaysDate(eventsByDate: [(Date, [Event])]) -> Int? {
        let dates = eventsByDate.map { $0.0 }
        let currentDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: .now) ?? .now
        guard let closestDate = dates.min(by: { abs($0.timeIntervalSince(currentDate)) < abs($1.timeIntervalSince(currentDate)) }) else {
            return nil
        }
        return dates.firstIndex(of: closestDate)
    }
}
