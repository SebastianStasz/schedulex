//
//  Publisher+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Combine
import Foundation

extension Publisher {
    func perform<T>(
        isLoading: DriverState<Bool>? = nil,
        errorTracker: DriverSubject<Error>? = nil,
        _ perform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Publishers.SetFailureType<AnyPublisher<T, Never>, Never>, Self> {
        flatMap {
            Just($0)
                .onNext { _ in isLoading?.send(true) }
                .await(perform)
                .catch(isLoading: isLoading, errorTracker: errorTracker)
                .receive(on: DispatchQueue.main)
                .onNext { _ in isLoading?.send(false) }
                .eraseToAnyPublisher()
        }
    }

    func perform<O: AnyObject, T>(
        on object: O,
        isLoading: DriverState<Bool>? = nil,
        errorTracker: DriverSubject<Error>? = nil,
        _ perform: @escaping (O, Output) async throws -> T
    ) -> Publishers.FlatMap<Publishers.SetFailureType<AnyPublisher<T, Never>, Never>, Self> {
        flatMap { [weak object] in
            Just($0)
                .onNext { _ in isLoading?.send(true) }
                .await(on: object, perform: perform)
                .catch(isLoading: isLoading, errorTracker: errorTracker)
                .receive(on: DispatchQueue.main)
                .onNext { _ in isLoading?.send(false) }
                .eraseToAnyPublisher()
        }
    }

    private func `catch`(isLoading: DriverState<Bool>?, errorTracker: DriverSubject<Error>? = nil) -> AnyPublisher<Output, Never> {
        `catch` { error -> AnyPublisher<Output, Never> in
            DispatchQueue.main.async {
                errorTracker?.send(error)
                isLoading?.send(false)
            }
            Swift.print("-----")
            Swift.print("‼️ \(error)")
            Swift.print("-----")
            return Just(nil).compactMap { $0 }.eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == Never {
    /// Wraps this publisher with a type eraser.
    func asDriver() -> Driver<Output> {
        eraseToAnyPublisher()
    }

    func asVoid() -> Driver<Void> {
        map { _ in }.asDriver()
    }

    func sinkAndStore<VM: CombineHelper>(on viewModel: VM, action: @escaping (VM, Output) -> Void) {
        sink { [weak viewModel] value in
            guard let viewModel = viewModel else { return }
            action(viewModel, value)
        }
        .store(in: &viewModel.cancellables)
    }
}

extension Publisher {
    func onNext(_ perform: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { perform($0) }).eraseToAnyPublisher()
    }

    func map<O: AnyObject, T>(with object: O, transform: @escaping (O, Output) -> T) -> AnyPublisher<T, Failure> {
        compactMap { [weak object] in
            guard let object = object else { return nil }
            return transform(object, $0)
        }
        .eraseToAnyPublisher()
    }

    func flatMap<O: AnyObject, T>(with object: O, transform: @escaping (O, Output) -> AnyPublisher<T, Failure>) -> AnyPublisher<T, Failure> {
        flatMap { [weak object] in
            guard let object = object else {
                return Empty<T, Failure>().eraseToAnyPublisher()
            }
            return transform(object, $0)
        }
        .eraseToAnyPublisher()
    }

    func onNext<T: AnyObject>(on object: T, perform: @escaping (T, Output) -> Void) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput:  { [weak object] output in
            guard let object = object else { return }
            perform(object, output)
        })
        .eraseToAnyPublisher()
    }

    func onNext<T: AnyObject>(on object: T, perform: @escaping (T) -> Void) -> AnyPublisher<Output, Failure> where Output == Void {
        handleEvents(receiveOutput:  { [weak object] output in
            guard let object = object else { return }
            perform(object)
        })
        .eraseToAnyPublisher()
    }

    /// Executes a unit of asynchronous work and returns its result to the downstream subscriber.
    ///
    /// - Parameter transform: A closure that takes an element as a parameter and returns a publisher that produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream  publisher into a publisher of that element's type.
    func asyncMap<T>(_ transform: @escaping (Output) async -> T) -> AnyPublisher<T, Failure> {
        flatMap { value -> Future<T, Failure> in
            Future { promise in
                Task {
                    let result = await transform(value)
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    /// Executes a unit of asynchronous work and returns its result to the downstream subscriber. Can throw an error.
    /// - Parameter transform: A closure that takes an element as a parameter and returns a publisher that produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream  publisher into a publisher of that element's type.
    func `await`<T>(_ transform: @escaping (Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }

    /// Executes a unit of asynchronous work and returns its result to the downstream subscriber. Can throw an error.
    /// - Parameter transform: A closure that takes an element as a parameter and returns a publisher that produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream  publisher into a publisher of that element's type.
    func `await`<O: AnyObject, T>(on object: O, transform: @escaping (O, Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
        flatMap { value in
            Future { [weak object] promise in
                guard let object = object else { return }
                Task {
                    do {
                        let output = try await transform(object, value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }

    /// Executes a unit of asynchronous work and returns its result to the downstream subscriber. Can throw an error.
    /// - Parameter transform: A closure that takes an element as a parameter and returns a publisher that produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream  publisher into a publisher of that element's type.
    func `await`<O: AnyObject, T>(on object: O?, perform: @escaping (O, Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
        flatMap { value in
            Future { [weak object] promise in
                guard let object = object else { return }
                Task {
                    do {
                        let output = try await perform(object, value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }

    /// Includes the current element as well as the previous element from the upstream publisher in a tuple where the previous element is optional.
    /// The first time the upstream publisher emits an element, the previous element will be `nil`.
    /// - Returns: A publisher of a tuple of the previous and current elements from the upstream publisher.
    func withPrevious() -> AnyPublisher<(previous: Output?, current: Output), Failure> {
        scan(Optional<(Output?, Output)>.none) { ($0?.1, $1) }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    /// Includes the current element as well as the previous element from the upstream publisher in a tuple where the previous element is not optional.
    /// The first time the upstream publisher emits an element, the previous element will be the `initialPreviousValue`.
    /// - Parameter initialPreviousValue: The initial value to use as the "previous" value when the upstream publisher emits for the first time.
    /// - Returns: A publisher of a tuple of the previous and current elements from the upstream publisher.
    func withPrevious(startWith initialPreviousValue: Output) -> AnyPublisher<(previous: Output, current: Output), Failure> {
        scan((initialPreviousValue, initialPreviousValue)) { ($0.1, $1) }.eraseToAnyPublisher()
    }
}
