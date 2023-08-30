//
//  Navigator.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Foundation

protocol Navigator {
    associatedtype Destination

    var presenter: Presenter { get }

    func navigate(to destination: Destination)
}
