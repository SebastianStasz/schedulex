//
//  RootView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import SwiftUI

public protocol RootView: View {
    associatedtype RootBody: View
    associatedtype Store: RootStore

    init(store: Store)

    var rootBody: RootBody { get }
    var store: Store { get }
}

public extension RootView {
    var body: some View {
        rootBody
    }
}
