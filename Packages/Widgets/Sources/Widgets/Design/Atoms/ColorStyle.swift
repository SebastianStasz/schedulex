//
//  ColorStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

public enum ColorStyle: CaseIterable {
    case backgroundPrimary
    case backgroundSecondary
    case grayShade1
    case accentPrimary
    case textPrimary
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
        case .grayShade1:
            return "gray_shade_1"
        case .accentPrimary:
            return "accent_primary"
        case .textPrimary:
            return "text_primary"
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

    var uiColor: UIColor {
        UIColor(named: name)!
    }

    var color: Color {
        Color(name, bundle: .module)
    }
}
