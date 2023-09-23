//
//  Icon.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

public enum Icon: String, Identifiable, CaseIterable {
    case closeButton

    public var id: String {
        rawValue
    }

    var name: String {
        switch self {
        case .closeButton:
            return "xmark.circle.fill"
        }
    }
}
