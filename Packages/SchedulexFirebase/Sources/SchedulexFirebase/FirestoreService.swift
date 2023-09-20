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

    public func getCracowUniversityOfEconomicsEvents(for group: FacultyGroup) async throws -> FacultyGroupEvents {
        let document = try await db.collection("schools").document("cracow_university_of_economics").collection("faculties").document(group.facultyDocument).collection("groups").document(group.name.lowercased()).getDocument()
        return try! document.data(as: FacultyGroupEvents.self)
    }
}
