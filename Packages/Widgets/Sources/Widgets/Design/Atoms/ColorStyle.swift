//
//  ColorStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import Resources
import SwiftUI

public enum ColorStyle: CaseIterable {
    case backgroundPrimary
    case backgroundSecondary
    case backgroundTertiary
    case grayShade1
    case grayShade2
    case accentPrimary
    case greenPrimary
    case textPrimary
    case textSecondary
    case textTertiary
    case blueShade1
    case blueShade2
    case blueShade3
    case blueShade4

    var name: String {
        switch self {
        case .backgroundPrimary:
            return "background_primary"
        case .backgroundSecondary:
            return "background_secondary"
        case .backgroundTertiary:
            return "background_tertiary"
        case .grayShade1:
            return "gray_shade_1"
        case .grayShade2:
            return "gray_shade_2"
        case .accentPrimary:
            return "accent_primary"
        case .greenPrimary:
            return "green_primary"
        case .textPrimary:
            return "text_primary"
        case .textSecondary:
            return "text_secondary"
        case .textTertiary:
            return "text_tertiary"
        case .blueShade1:
            return "blue_shade_1"
        case .blueShade2:
            return "blue_shade_2"
        case .blueShade3:
            return "blue_shade_3"
        case .blueShade4:
            return "blue_shade_4"
        }
    }

    var color: Color {
        switch self {
        case .backgroundPrimary:
            return .backgroundPrimary
        case .backgroundSecondary:
            return .backgroundSecondary
        case .backgroundTertiary:
            return .backgroundTertiary
        case .grayShade1:
            return .grayShade1
        case .grayShade2:
            return .grayShade2
        case .accentPrimary:
            return .accentPrimary
        case .greenPrimary:
            return .greenPrimary
        case .textPrimary:
            return .textPrimary
        case .textSecondary:
            return .textSecondary
        case .textTertiary:
            return .textTertiary
        case .blueShade1:
            return .blueShade1
        case .blueShade2:
            return .blueShade2
        case .blueShade3:
            return .blueShade3
        case .blueShade4:
            return .blueShade4
        }
    }
}
