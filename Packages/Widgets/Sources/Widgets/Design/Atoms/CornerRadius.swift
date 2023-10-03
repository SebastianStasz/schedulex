//
//  CornerRadius.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

public enum CornerRadius: String, CaseIterable {
    case medium
    case large

    var value: CGFloat {
        switch self {
        case .medium:
            return 10
        case .large:
            return 12
        }
    }
}
