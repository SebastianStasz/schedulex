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
    private let db = Firestore.firestore()

    public init() {}

    public func getCracowUniversityOfEconomics() async throws -> School {
        let document = try await db.collection("schools").document("cracow_university_of_economics").getDocument()
        return try! document.data(as: School.self)
    }
}
