//
//  WithLatestFromPublisher.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Combine
import Foundation

extension Publishers {
    struct WithLatestFrom<Upstream: Publisher,
        Other: Publisher,
        Output>: Publisher where Upstream.Failure == Other.Failure
    {
        typealias Failure = Upstream.Failure
        typealias ResultSelector = (Upstream.Output, Other.Output) -> Output

        private let upstream: Upstream
        private let second: Other
        private let resultSelector: ResultSelector
        private var latestValue: Other.Output?

        init(upstream: Upstream,
             second: Other,
             resultSelector: @escaping ResultSelector)
        {
            self.upstream = upstream
            self.second = second
            self.resultSelector = resultSelector
        }

        func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
            let sub = Subscription(upstream: upstream,
                                   second: second,
                                   resultSelector: resultSelector,
                                   subscriber: subscriber)
            subscriber.receive(subscription: sub)
        }
    }
}
