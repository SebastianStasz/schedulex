//
//  CombineUtils.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Combine

typealias CombineLatest = Publishers.CombineLatest
typealias CombineLatest3 = Publishers.CombineLatest3
typealias CombineLatest4 = Publishers.CombineLatest4

typealias Merge = Publishers.Merge
typealias Merge3 = Publishers.Merge3
typealias Merge4 = Publishers.Merge4
typealias Merge5 = Publishers.Merge5
typealias Merge6 = Publishers.Merge6

typealias Driver<T> = AnyPublisher<T, Never>
typealias DriverState<T> = CurrentValueSubject<T, Never>
typealias DriverSubject<T> = PassthroughSubject<T, Never>
