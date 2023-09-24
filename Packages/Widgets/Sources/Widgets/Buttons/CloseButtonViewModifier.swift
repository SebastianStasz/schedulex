//
//  CloseButtonViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 22/09/2023.
//

import SwiftUI

private struct CloseButtonViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close", systemImage: Icon.closeButton.name, action: dismiss.callAsFunction)
                        .tint(.grayShade1)
                        .labelStyle(.iconOnly)
                }
            }
    }
}

public extension View {
    func closeButton() -> some View {
        modifier(CloseButtonViewModifier())
    }
}
