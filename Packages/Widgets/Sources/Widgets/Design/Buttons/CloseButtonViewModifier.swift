//
//  CloseButtonViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 22/09/2023.
//

import Resources
import SwiftUI

private struct CloseButtonViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(L10n.doneButton) { dismiss.callAsFunction() }
                        .tint(.accentPrimary)
                        .fontWeight(.medium)
                }
            }
    }
}

public extension View {
    func closeButton() -> some View {
        modifier(CloseButtonViewModifier())
    }
}
