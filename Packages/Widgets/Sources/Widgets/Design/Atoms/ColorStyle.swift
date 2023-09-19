//
//  ColorStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

enum ColorStyle: CaseIterable {
    case backgroundPrimary
    case backgroundSecondary
    case grayShade1
    case accentPrimary
    case textPrimary

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
        }
    }

    var uiColor: UIColor {
        UIColor(named: name)!
    }

    var color: Color {
        Color(name, bundle: .module)
    }
}
