//
//  ViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import UIKit

@MainActor
protocol ViewModel {
    var navigationController: UINavigationController? { get set }
    associatedtype Store

    func makeStore(context: Context) -> Store
}
