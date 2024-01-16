//
//  FirestoreStorageProtocol.swift
//  SchedulexFirebase
//
//  Created by Sebastian Staszczyk on 16/01/2024.
//

import Combine
import Domain
import Foundation

public protocol FirestoreStorageProtocol {
    var appConfiguration: AnyPublisher<AppConfiguration, Never> { get }

    func getCracowUniversityOfEconomicsData() async throws -> School
}
