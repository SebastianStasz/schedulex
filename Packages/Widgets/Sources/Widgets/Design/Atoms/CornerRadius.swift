//
//  CornerRadius.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

public enum CornerRadius: String, CaseIterable {
    case mini
    case medium
    case large

    var value: CGFloat {
        switch self {
        case .mini:
            return 4
        case .medium:
            return 10
        case .large:
            return 12
        }
    }
}
