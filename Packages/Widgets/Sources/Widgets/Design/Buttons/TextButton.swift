//
//  TextButton.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import SwiftUI

private struct TextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, .small)
            .foregroundStyle(.accentPrimary)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

public struct TextButton: View {
    private let title: String
    private let disabled: Bool
    private let action: () -> Void

    public init(_ title: String, disabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.disabled = disabled
        self.action = action
    }

    public var body: some View {
        Button(title, action: action)
            .buttonStyle(TextButtonStyle())
            .disabled(disabled)
            .opacity(disabled ? 0.5 : 1)
    }
}

#Preview {
    TextButton("Button", action: {})
}
