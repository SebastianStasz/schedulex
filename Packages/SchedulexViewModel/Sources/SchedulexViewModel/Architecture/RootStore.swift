//
//  RootStore.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Combine

@MainActor
open class RootStore: ObservableObject, CombineHelper {
    public var cancellables: Set<AnyCancellable> = []

    public init() {}

    public let viewDidLoad = PassthroughSubject<Void, Never>()
    public let viewWillAppear = PassthroughSubject<Void, Never>()
    public let viewDidAppear = PassthroughSubject<Void, Never>()
    public let viewDidAppearForTheFirstTime = PassthroughSubject<Void, Never>()
    public let viewWillDisappear = PassthroughSubject<Void, Never>()
    public let viewDidDisappear = PassthroughSubject<Void, Never>()
}
