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
    private var school: School?

    public init() {}

    public func getCracowUniversityOfEconomics() async throws -> School {
        if let school {
            return school
        }
        return try await fetchCracowUniversityOfEconomics()
    }

    private func fetchCracowUniversityOfEconomics() async throws -> School {
        let document = try await db.collection("schools").document("cracow_university_of_economics").getDocument()
        let school = try! document.data(as: School.self)
        self.school = school
        return school
    }
}
