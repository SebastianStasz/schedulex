//
//  FacultyGroupColor+Color.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 12/10/2023.
//

import Domain
import SwiftUI
import Widgets

extension FacultyGroupColor {
    var shade1: Color {
        switch self {
        case .blue:
            return .blueShade1
        case .yellow:
            return .yellowShade1
        case .green:
            return .greenShade1
        case .purple:
            return .purpleShade1
        case .orange:
            return .orangeShade1
        case .red:
            return .redShade1
        }
    }

    var shade2: Color {
        switch self {
        case .blue:
            return .blueShade2
        case .yellow:
            return .yellowShade2
        case .green:
            return .greenShade2
        case .purple:
            return .purpleShade2
        case .orange:
            return .orangeShade2
        case .red:
            return .redShade2
        }
    }

    var shade3: Color {
        switch self {
        case .blue:
            return .blueShade3
        case .yellow:
            return .yellowShade3
        case .green:
            return .greenShade3
        case .purple:
            return .purpleShade3
        case .orange:
            return .orangeShade3
        case .red:
            return .redShade3
        }
    }

    var shade4: Color {
        switch self {
        case .blue:
            return .blueShade4
        case .yellow:
            return .yellowShade4
        case .green:
            return .greenShade4
        case .purple:
            return .purpleShade4
        case .orange:
            return .orangeShade4
        case .red:
            return .redShade4
        }
    }
}
