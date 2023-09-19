//
//  DesignSystemListSection.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import Foundation

enum DesignSystemListSection: String, CaseIterable {
    case atoms

    var name: String {
        rawValue.capitalized
    }

    var items: [DesignSystemListItem] {
        switch self {
        case .atoms:
            return [.typography, .color, .spacing, .icon]
        }
    }
}
