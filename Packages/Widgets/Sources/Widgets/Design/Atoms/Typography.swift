//
//  Typography.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

public enum Typography: CaseIterable {
    case titleSmall
    case bodyMedium
    case body
    case note

    var name: String {
        switch self {
        case .titleSmall:
            return "Title small"
        case .bodyMedium:
            return "Body medium"
        case .body:
            return "Body"
        case .note:
            return "Note"
        }
    }

    var font: Font {
        switch self {
        case .titleSmall:
            return .system(size: 22, weight: .semibold)
        case .bodyMedium:
            return .system(size: 17, weight: .semibold)
        case .body:
            return .system(size: 17)
        case .note:
            return .system(size: 13)
        }
    }
}
