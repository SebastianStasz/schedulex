//
//  FirestoreService.swift
//  SchedulexFirebase
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final public class FirestoreService: ObservableObject {
    private lazy var db = Firestore.firestore()
    private var nextUpdateDate: Date?
    private var school: School?

    public init() {}

    public func subscribeToAppSettings() -> PassthroughSubject<AppConfiguration?, Never> {
        let publisher = PassthroughSubject<AppConfiguration?, Never>()
        db.collection("app").document("configuration")
            .addSnapshotListener { document, error in
                if let document {
                    let appConfiguration = try? document.data(as: AppConfiguration.self)
                    publisher.send(appConfiguration)
                }
            }
        return publisher
    }

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
