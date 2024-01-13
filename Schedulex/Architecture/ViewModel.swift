//
//  ViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Foundation


protocol ViewModel {
    associatedtype Store

    func makeStore(context: Context) -> Store
}
