//
//  ViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Foundation
import SchedulexFirebase

protocol ViewModel {
    associatedtype Store

    func makeStore(storage: FirestoreService) -> Store
}
