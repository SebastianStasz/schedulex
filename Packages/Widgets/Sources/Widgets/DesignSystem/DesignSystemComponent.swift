//
//  DesignSystemComponent.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

private struct DesignSystemComponent: ViewModifier {
    let name: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text(name, style: .body)
            content
        }
    }
}

extension View {
    func designSystemComponent(name: String) -> some View {
        modifier(DesignSystemComponent(name: name))
    }
}
