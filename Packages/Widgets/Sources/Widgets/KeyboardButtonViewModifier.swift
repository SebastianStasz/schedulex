//
//  KeyboardButtonViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 08/10/2023.
//

import SwiftUI

private struct KeyboardButtonViewModifier: ViewModifier {
    let title: String
    let disabled: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    TextButton(title, style: .bodyMedium, color: .blue, disabled: disabled, action: action)
                }
            }
    }
}

public extension View {
    func keyboardButton(_ title: String, disabled: Bool = false, action: @escaping () -> Void) -> some View {
        modifier(KeyboardButtonViewModifier(title: title, disabled: disabled, action: action))
    }
}
