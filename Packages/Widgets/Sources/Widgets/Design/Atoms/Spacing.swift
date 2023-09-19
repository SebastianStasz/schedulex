//
//  Spacing.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import Foundation

enum Spacing: String, CaseIterable {
    case micro
    case small
    case medium
    case large
    case xlarge

    var name: String {
        rawValue
    }

    var value: CGFloat {
        switch self {
        case .micro:
            return 4
        case .small:
            return 8
        case .medium:
            return 12
        case .large:
            return 16
        case .xlarge:
            return 24
        }
    }
}
