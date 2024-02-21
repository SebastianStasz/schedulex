//
//  DashboardEventsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/01/2024.
//

import Combine
import Domain
import Foundation
import Widgets
import UEKScraper

struct DashboardEventsViewModel {
    struct Input {
        let fetchEvents: Driver<Void>
        let forceRefresh: Driver<Void>
        let facultyGroups: Driver<[FacultyGroup]>
        let hiddenClasses: Driver<[EditableFacultyGroupClass]>
    }

    struct Output {
        let dayPickerItems: Driver<[DayPickerItem]?>
        let facultiesGroupsDetails: Driver<[FacultyGroupDetails]>
        let eventsToDisplay: Driver<[Event]>
        let isLoading: Driver<Bool>
    }

    private let service = UekScheduleService()

    func makeOutput(input: Input) -> Output {
        let isLoading = DriverState(false)
        var nextUpdateDate: Date?

        let facultyGroups = input.facultyGroups
            .removeDuplicates()
            .onNext { _ in nextUpdateDate = nil }

        let fetchEvents = input.fetchEvents
            .filter { shouldRefreshEvents(nextUpdateDate: nextUpdateDate) }

        let fetchEventsForFacultyGroups = Merge(fetchEvents, input.forceRefresh)
            .withLatestFrom(facultyGroups)

        let allFacultiesGroupsDetails = fetchEventsForFacultyGroups
            .perform(isLoading: isLoading) { try await fetchFacultiesGroupsDetails(for: $0) }
            .onNext { _ in nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 5, to: .now) }
            .share()

        let eventsToDisplay = CombineLatest(allFacultiesGroupsDetails, input.hiddenClasses)
            .onNext { _ in isLoading.send(true) }
            .map { $0.0.mapToEventsWithoutHiddenClasses(hiddenClasses: $0.1) }
            .share()

        let dayPickerItems = eventsToDisplay
            .receive(on: DispatchQueue.global(qos: .background))
            .map { $0.mapToDayPickerItems() }
            .receive(on: DispatchQueue.main)
            .onNext { _ in isLoading.send(false) }

        return Output(dayPickerItems: dayPickerItems.asDriver(),
                      facultiesGroupsDetails: allFacultiesGroupsDetails.asDriver(),
                      eventsToDisplay: eventsToDisplay.asDriver(),
                      isLoading: isLoading.asDriver())
    }

    private func shouldRefreshEvents(nextUpdateDate: Date?) -> Bool {
        guard let nextUpdateDate else { return true }
        return nextUpdateDate <= Date.now
    }

    private func fetchFacultiesGroupsDetails(for facultyGroups: [FacultyGroup]) async throws -> [FacultyGroupDetails] {
        var facultyGroupsDetails: [FacultyGroupDetails] = []
        for facultyGroup in facultyGroups {
            let facultyGroupDetails = try await service.getFacultyGroupDetails(for: facultyGroup)
            facultyGroupsDetails.append(facultyGroupDetails)
        }
        return facultyGroupsDetails
    }
}

private extension [FacultyGroupDetails] {
    func mapToEventsWithoutHiddenClasses(hiddenClasses: [EditableFacultyGroupClass]) -> [Event] {
        var events: [Event] = []
        for facultyGroupDetails in self {
            guard !facultyGroupDetails.isHidden else { continue }
            let hiddenClasses = hiddenClasses
                .filter { $0.facultyGroupName == facultyGroupDetails.name }
                .map { $0.toFacultyGroupClass() }

            let newEvents = facultyGroupDetails.events
                .filter { !hiddenClasses.contains($0.class) }

            events.append(contentsOf: newEvents)
        }
        return events
    }
}

private extension [Event] {
    func mapToDayPickerItems() -> [DayPickerItem]? {
        let eventsByDate = self.sorted(by: { $0.startDate! < $1.startDate! })
        
        guard let startDate = eventsByDate.first?.startDate,
              let endDate = eventsByDate.last?.startDate
        else { return nil }

        let stopDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)!
        var dates: [Date] = []
        var date = startDate
        
        while date < stopDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }

        let eventsByDay = Dictionary(grouping: eventsByDate, by: { $0.startDate?.formatted(date: .numeric, time: .omitted) })

        return dates.map { date in
            if let events = eventsByDay[date.formatted(date: .numeric, time: .omitted)] {
                let colors = Set(events.map { $0.facultyGroupColor })
                    .sorted(by: { $0.id < $1.id })
                    .map { $0.representative }
                return DayPickerItem(date: date, circleColors: colors)
            }
            return DayPickerItem(date: date, circleColors: [])
        }
    }
}

public extension Publisher {
    ///  Merges two publishers into a single publisher by combining each value
    ///  from self with the latest value from the second publisher, if any.
    ///
    ///  - parameter other: Second observable source.
    ///  - parameter resultSelector: Function to invoke for each value from the self combined
    ///                              with the latest value from the second source, if any.
    ///
    ///  - returns: A publisher containing the result of combining each value of the self
    ///             with the latest value from the second publisher, if any, using the
    ///             specified result selector function.
    func withLatestFrom<Other: Publisher, Result>(_ other: Other,
                                                  resultSelector: @escaping (Output, Other.Output) -> Result)
    -> Publishers.WithLatestFrom<Self, Other, Result> {
        return .init(upstream: self, second: other, resultSelector: resultSelector)
    }

    ///  Upon an emission from self, emit the latest value from the
    ///  second publisher, if any exists.
    ///
    ///  - parameter other: Second observable source.
    ///
    ///  - returns: A publisher containing the latest value from the second publisher, if any.
    func withLatestFrom<Other: Publisher>(_ other: Other)
    -> Publishers.WithLatestFrom<Self, Other, Other.Output> {
        return .init(upstream: self, second: other) { $1 }
    }
}

// MARK: - Publisher
extension Publishers {
    public struct WithLatestFrom<Upstream: Publisher,
                                 Other: Publisher,
                                 Output>: Publisher where Upstream.Failure == Other.Failure {
        public typealias Failure = Upstream.Failure
        public typealias ResultSelector = (Upstream.Output, Other.Output) -> Output

        private let upstream: Upstream
        private let second: Other
        private let resultSelector: ResultSelector
        private var latestValue: Other.Output?

        init(upstream: Upstream,
             second: Other,
             resultSelector: @escaping ResultSelector) {
            self.upstream = upstream
            self.second = second
            self.resultSelector = resultSelector
        }

        public func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
            let sub = Subscription(upstream: upstream,
                                   second: second,
                                   resultSelector: resultSelector,
                                   subscriber: subscriber)
            subscriber.receive(subscription: sub)
        }
    }
}

// MARK: - Subscription
extension Publishers.WithLatestFrom {
    private class Subscription<S: Subscriber>: Combine.Subscription where S.Input == Output, S.Failure == Failure {
        private let subscriber: S
        private let resultSelector: ResultSelector
        private var latestValue: Other.Output?

        private let upstream: Upstream
        private let second: Other

        private var firstSubscription: Cancellable?
        private var secondSubscription: Cancellable?

        init(upstream: Upstream,
             second: Other,
             resultSelector: @escaping ResultSelector,
             subscriber: S) {
            self.upstream = upstream
            self.second = second
            self.subscriber = subscriber
            self.resultSelector = resultSelector
            trackLatestFromSecond()
        }

        func request(_ demand: Subscribers.Demand) {
            // withLatestFrom always takes one latest value from the second
            // observable, so demand doesn't really have a meaning here.
            firstSubscription = upstream
                .sink(
                    receiveCompletion: { [subscriber] in subscriber.receive(completion: $0) },
                    receiveValue: { [weak self] value in
                        guard let self = self else { return }

                        guard let latest = self.latestValue else { return }
                        _ = self.subscriber.receive(self.resultSelector(value, latest))
                    })
        }

        // Create an internal subscription to the `Other` publisher,
        // constantly tracking its latest value
        private func trackLatestFromSecond() {
            let subscriber = AnySubscriber<Other.Output, Other.Failure>(
                receiveSubscription: { [weak self] subscription in
                    self?.secondSubscription = subscription
                    subscription.request(.unlimited)
                },
                receiveValue: { [weak self] value in
                    self?.latestValue = value
                    return .unlimited
                },
                receiveCompletion: nil)

            self.second.subscribe(subscriber)
        }

        func cancel() {
            firstSubscription?.cancel()
            secondSubscription?.cancel()
        }
    }
}
