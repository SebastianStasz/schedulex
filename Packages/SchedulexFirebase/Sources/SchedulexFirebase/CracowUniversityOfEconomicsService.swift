//
//  CracowUniversityOfEconomicsService.swift
//  SchedulexFirebase
//
//  Created by Sebastian Staszczyk on 16/01/2024.
//

import Domain
import FirebaseFirestoreSwift
import Foundation

final class CracowUniversityOfEconomicsService {
    private let firestore: FirestoreService
    private var nextUpdateDate: Date?
    private var school: School?

    init(firestore: FirestoreService) {
        self.firestore = firestore
    }

    func getCracowUniversityOfEconomics() async throws -> School {
        guard shouldUseCachedData else {
            return try await fetchCracowUniversityOfEconomics()
        }
        if let school {
            return school
        }
        return try await fetchCracowUniversityOfEconomics()
    }

    private func fetchCracowUniversityOfEconomics() async throws -> School {
        let document = try await firestore.getDocument("cracow_university_of_economics", from: "schools")
        let school = try! document.data(as: School.self)
        nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: .now)
        self.school = school
        return school
    }

    private var shouldUseCachedData: Bool {
        guard let nextUpdateDate, nextUpdateDate >= Date.now else {
            return false
        }
        return true
    }
}
