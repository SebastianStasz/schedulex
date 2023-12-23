//
//  Icon.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

public enum Icon: String, Identifiable, CaseIterable {
    case closeButton
    case delete
    case info
    case circle
    case circleFill
    case checkmark
    case chevronRight
    case plusCircle

    public var id: String {
        rawValue
    }

    var name: String {
        switch self {
        case .closeButton:
            return "xmark"
        case .delete:
            return "trash.fill"
        case .info:
            return "info.circle"
        case .circle:
            return "circle"
        case .circleFill:
            return "circle.fill"
        case .checkmark:
            return "checkmark.circle.fill"
        case .chevronRight:
            return "chevron.right"
        case .plusCircle:
            return "plus.circle"
        }
    }
}
