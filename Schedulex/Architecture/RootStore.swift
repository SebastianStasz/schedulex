//
//  RootStore.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Combine

@MainActor
class RootStore: ObservableObject, CombineHelper {
    var cancellables: Set<AnyCancellable> = []

    let viewDidLoad = PassthroughSubject<Void, Never>()
    let viewWillAppear = PassthroughSubject<Void, Never>()
    let viewDidAppear = PassthroughSubject<Void, Never>()
    let viewWillDisappear = PassthroughSubject<Void, Never>()
    let viewDidDisappear = PassthroughSubject<Void, Never>()
}
