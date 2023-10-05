//
//  FirestoreService.swift
//  SchedulexFirebase
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import FirebaseFirestore
import FirebaseFirestoreSwift

final public class FirestoreService {
    private lazy var db = Firestore.firestore()
    private var lastUpdateDate: Date = .now
    private var school: School?

    public init() {}

    public func getCracowUniversityOfEconomics() async throws -> School {
        guard shouldUseCachedData else {
            return try await fetchCracowUniversityOfEconomics()
        }
        if let school {
            return school
        }
        return try await fetchCracowUniversityOfEconomics()
    }

    private func fetchCracowUniversityOfEconomics() async throws -> School {
        let document = try await db.collection("schools").document("cracow_university_of_economics").getDocument()
        let school = try! document.data(as: School.self)
        lastUpdateDate = .now
        self.school = school
        return school
    }

    private var shouldUseCachedData: Bool {
        let fetchAgainDate = Calendar.current.date(byAdding: .hour, value: 1, to: lastUpdateDate)
        guard let fetchAgainDate, fetchAgainDate >= Date.now else {
            return false
        }
        return true
    }
}
