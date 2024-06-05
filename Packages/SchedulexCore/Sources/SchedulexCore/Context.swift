//
//  Context.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Foundation
import SchedulexFirebase

public final class Context {
    public let storage: FirestoreStorage
    @Published public var appData: AppData

    init(storage: FirestoreStorage, appData: AppData) {
        self.storage = storage
        self.appData = appData
    }
}
