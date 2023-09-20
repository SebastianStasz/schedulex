//
//  DashboardViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Foundation
import SchedulexFirebase

struct DashboardViewModel: ViewModel {
    func makeStore(storage: FirestoreService) -> DashboardStore {
        let store = DashboardStore()
        return store
    }
}
