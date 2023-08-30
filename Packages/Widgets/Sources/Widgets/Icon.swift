//
//  Icon.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

public enum Icon: String, Identifiable, CaseIterable {
    case tabBar1 = "house"
    case tabBar2 = "graduationcap"

    public var id: String { rawValue }

    var name: String {
        switch self {
        case .tabBar1:
            return "tabBar1"
        case .tabBar2:
            return "tabBar2"
        }
    }
}
