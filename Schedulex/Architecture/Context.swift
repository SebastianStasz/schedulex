//
//  Context.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Foundation
import SchedulexFirebase

final class Context {
    let firestoreService: FirestoreService
    @Published var appData: AppData

    init(firestoreService: FirestoreService, appData: AppData) {
        self.firestoreService = firestoreService
        self.appData = appData
    }
}
