//
//  WithLatestFromSubscription.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Combine
import Foundation

extension Publishers.WithLatestFrom {
    class Subscription<S: Subscriber>: Combine.Subscription where S.Input == Output, S.Failure == Failure {
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
             subscriber: S)
        {
            self.upstream = upstream
            self.second = second
            self.subscriber = subscriber
            self.resultSelector = resultSelector
            trackLatestFromSecond()
        }

        func request(_: Subscribers.Demand) {
            // withLatestFrom always takes one latest value from the second
            // observable, so demand doesn't really have a meaning here.
            firstSubscription = upstream
                .sink(
                    receiveCompletion: { [subscriber] in subscriber.receive(completion: $0) },
                    receiveValue: { [weak self] value in
                        guard let self = self else { return }

                        guard let latest = self.latestValue else { return }
                        _ = self.subscriber.receive(self.resultSelector(value, latest))
                    }
                )
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
                receiveCompletion: nil
            )

            second.subscribe(subscriber)
        }

        func cancel() {
            firstSubscription?.cancel()
            secondSubscription?.cancel()
        }
    }
}
