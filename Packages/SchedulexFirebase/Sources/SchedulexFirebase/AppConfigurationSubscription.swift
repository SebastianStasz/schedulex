//
//  AppConfigurationSubscription.swift
//  SchedulexFirebase
//
//  Created by Sebastian Staszczyk on 16/01/2024.
//

import Combine
import Domain
import FirebaseFirestore

final class AppConfigurationSubscription {
    private var listenerRegistration: ListenerRegistration?
    private var subscriptionCancellable: AnyCancellable?
    private let firestore: FirestoreService

    @Published private(set) var appConfiguration: AppConfiguration?

    init(firestore: FirestoreService) {
        self.firestore = firestore
    }

    func subscribe() {
        guard listenerRegistration == nil else { return }
        let subscription = firestore.subscribe(document: "configuration", from: "app")

        listenerRegistration = subscription.0
        
        subscriptionCancellable = subscription.1
            .compactMap { try? $0?.data(as: AppConfiguration.self) }
            .sink { [weak self] in self?.appConfiguration = $0 }
    }

    func unsubscribe() {
        subscriptionCancellable = nil
        listenerRegistration?.remove()
        listenerRegistration = nil
    }
}
