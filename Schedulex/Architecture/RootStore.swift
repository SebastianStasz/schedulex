//
//  RootStore.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Combine
import Foundation

class RootStore: ObservableObject {
    @Published var isLoading = false

    var cancellables: Set<AnyCancellable> = []

    let viewDidLoad = PassthroughSubject<Void, Never>()
    let viewWillAppear = PassthroughSubject<Void, Never>()
    let viewDidAppear = PassthroughSubject<Void, Never>()
    let viewWillDisappear = PassthroughSubject<Void, Never>()
    let viewDidDisappear = PassthroughSubject<Void, Never>()
    let viewWillAppearForTheFirstTime = PassthroughSubject<Void, Never>()
}
