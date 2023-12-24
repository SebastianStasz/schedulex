//
//  Typography.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI
import Resources

public enum Typography: CaseIterable {
    case titleSmall
    case bodyMedium
    case body
    case footnote
    case timeMedium
    case time
    case keyboardButton

    var name: String {
        switch self {
        case .titleSmall:
            return "Title small"
        case .bodyMedium:
            return "Body medium"
        case .body:
            return "Body"
        case .footnote:
            return "Footnote"
        case .timeMedium:
            return "Time medium"
        case .time:
            return "Time"
        case .keyboardButton:
            return "Keyboard button"
        }
    }

    var font: SwiftUI.Font {
        switch self {
        case .titleSmall:
            return .system(size: 22, weight: .semibold)
        case .bodyMedium:
            return .system(size: 16, weight: .medium)
        case .body:
            return .system(size: 17)
        case .footnote:
            return .system(size: 13)
        case .timeMedium:
            return FontFamily.Inconsolata.medium.swiftUIFont(size: 18, relativeTo: .footnote)
        case .time:
            return FontFamily.Inconsolata.regular.swiftUIFont(size: 16, relativeTo: .footnote)
        case .keyboardButton:
            return .system(size: 18, weight: .semibold)
        }
    }
}
