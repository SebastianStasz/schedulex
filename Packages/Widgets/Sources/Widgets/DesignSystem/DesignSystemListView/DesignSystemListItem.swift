//
//  DesignSystemListItem.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

enum DesignSystemListItem: String, CaseIterable {
    case typography
    case color
    case spacing
    case cornerRadius
    case icon

    var name: String {
        rawValue.capitalized
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .typography:
            TypographyDesignSystemView()
        case .color:
            ColorDesignSystemView()
        case .spacing:
            SpacingDesignSystemView()
        case .cornerRadius:
            CornerRadiusDesignSystemView()
        case .icon:
            Text("Icons", style: .body)
        }
    }
}
