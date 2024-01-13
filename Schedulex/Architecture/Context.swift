//
//  Context.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import SchedulexFirebase

final class Context {
    let firestoreService: FirestoreService
    let appData: AppData

    init(firestoreService: FirestoreService, appData: AppData) {
        self.firestoreService = firestoreService
        self.appData = appData
    }
}
