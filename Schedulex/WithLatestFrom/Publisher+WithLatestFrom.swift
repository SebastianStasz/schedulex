//
//  Publisher+WithLatestFrom.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Combine
import Foundation

extension Publisher {
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
        -> Publishers.WithLatestFrom<Self, Other, Result>
    {
        return .init(upstream: self, second: other, resultSelector: resultSelector)
    }

    ///  Upon an emission from self, emit the latest value from the
    ///  second publisher, if any exists.
    ///
    ///  - parameter other: Second observable source.
    ///
    ///  - returns: A publisher containing the latest value from the second publisher, if any.
    func withLatestFrom<Other: Publisher>(_ other: Other)
        -> Publishers.WithLatestFrom<Self, Other, Other.Output>
    {
        return .init(upstream: self, second: other) { $1 }
    }
}
