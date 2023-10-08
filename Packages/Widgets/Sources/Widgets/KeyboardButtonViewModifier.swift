//
//  KeyboardButtonViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 08/10/2023.
//

import SwiftUI

private struct KeyboardButtonViewModifier: ViewModifier, KeyboardReadable {
    @State private var isKeyboardVisible = false

    let title: String
    let disabled: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) { keyboardButton }
            .onReceive(keyboardPublisher, perform: onKeyboardVisibilityChanged)
    }

    private var keyboardButton: some View {
        VStack(spacing: 0) {
            Separator()
            TextButton(title, style: .keyboardButton, color: .blue, disabled: disabled, action: action)
                .tracking(0.5)
        }
        .frame(maxWidth: .infinity)
        .background(.backgroundSecondary)
        .opacity(isKeyboardVisible ? 1 : 0)
    }

    private func onKeyboardVisibilityChanged(to isVisible: Bool) {
        guard isVisible else {
            isKeyboardVisible = isVisible
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.1)) {
                isKeyboardVisible = isVisible
            }
        }
    }
}

public extension View {
    func keyboardButton(_ title: String, disabled: Bool = false, action: @escaping () -> Void) -> some View {
        modifier(KeyboardButtonViewModifier(title: title, disabled: disabled, action: action))
    }
}
