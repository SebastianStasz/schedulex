//
//  DashboardViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Foundation

struct DashboardViewModel: ViewModel {
    func makeStore() -> DashboardStore {
        let store = DashboardStore()
        return store
    }
}
