//
//  SchoolViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Foundation

struct SchoolViewModel: ViewModel {
    func makeStore() -> SchoolStore {
        let store = SchoolStore()
        return store
    }
}
