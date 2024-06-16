//
//  TextButtonStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import Resources
import SwiftUI

private struct TextButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(color)
            .padding(.vertical, .small)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

public struct TextButton: View {
    private let title: String
    private let style: Typography
    private let color: Color
    private let disabled: Bool
    private let action: () -> Void

    public init(_ title: String, style: Typography = .body, color: Color = .accentPrimary, disabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.color = color
        self.disabled = disabled
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title, style: style)
        }
        .buttonStyle(TextButtonStyle(color: color))
        .disabled(disabled)
        .opacity(disabled ? 0.4 : 1)
    }
}

#Preview {
    TextButton("Button", action: {})
}
