//
//  KeyboardButtonViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 08/10/2023.
//

import SwiftUI

private struct KeyboardButtonViewModifier: ViewModifier, KeyboardReadable {
    @Binding var isKeyboardVisible: Bool

    let title: String
    let disabled: Bool
    let isHidden: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        content.overlay(keyboardButton, alignment: .bottom)
    }

    private var keyboardButton: some View {
        Button(title, action: action)
            .buttonStyle(.primaryButtonStyle(isKeyboardVisible: isKeyboardVisible))
            .padding(.horizontal, .xlarge)
            .padding(.bottom, isKeyboardVisible ? .medium : 0)
            .disabled(disabled)
            .opacity(isHidden ? 0 : 1)
    }
}

public extension View {
    func keyboardButton(_ title: String, isKeyboardVisible: Binding<Bool>, disabled: Bool = false, isHidden: Bool = false, action: @escaping () -> Void) -> some View {
        modifier(KeyboardButtonViewModifier(isKeyboardVisible: isKeyboardVisible, title: title, disabled: disabled, isHidden: isHidden, action: action))
    }
}
