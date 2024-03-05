//
//  FirestoreStorage.swift
//  SchedulexFirebase
//
//  Created by Sebastian Staszczyk on 16/01/2024.
//

import Combine
import Domain
import Foundation

public final class FirestoreStorage: FirestoreStorageProtocol {
    private let firestore = FirestoreService()
    private let appConfigurationSubscription: AppConfigurationSubscription
    private let cracowUniversityOfEconomicsService: CracowUniversityOfEconomicsService

    public init() {
        appConfigurationSubscription = AppConfigurationSubscription(firestore: firestore)
        cracowUniversityOfEconomicsService = CracowUniversityOfEconomicsService(firestore: firestore)

        appConfigurationSubscription.subscribe()
    }
    
    public var appConfiguration: AnyPublisher<AppConfiguration, Never> {
        appConfigurationSubscription.$appConfiguration
            .map { $0 ?? .defaultConfiguration }
            .eraseToAnyPublisher()
    }

    public func getCracowUniversityOfEconomicsData() async throws -> School {
        try await cracowUniversityOfEconomicsService.getCracowUniversityOfEconomics()
    }
}
