//
//  FirestoreService.swift
//  SchedulexFirebase
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Combine
import FirebaseFirestore

struct FirestoreService {
    private let db = Firestore.firestore()

    func subscribe(document: String, from collection: String) -> (ListenerRegistration, AnyPublisher<DocumentSnapshot?, Never>) {
        let publisher = PassthroughSubject<DocumentSnapshot?, Never>()
        let listenerRegistration = db.collection(collection).document(document)
            .addSnapshotListener { document, error in
                if let document {
                    publisher.send(document)
                }
            }
        return (listenerRegistration, publisher.eraseToAnyPublisher())
    }

    func getDocument(_ document: String, from collection: String) async throws -> DocumentSnapshot {
        try await db.collection(collection).document(document).getDocument()
    }
}
