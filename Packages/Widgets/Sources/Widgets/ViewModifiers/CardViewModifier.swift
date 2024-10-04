//
//  CardViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

private struct CardViewModifier: ViewModifier {
    let verticalPadding: CGFloat
    let horizontalPadding: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(.backgroundTertiary)
            .cornerRadius(.medium)
    }
}

public extension View {
    func card(vertical: CGFloat = .large, horizontal: CGFloat = .large) -> some View {
        modifier(CardViewModifier(verticalPadding: vertical, horizontalPadding: horizontal))
    }
}
