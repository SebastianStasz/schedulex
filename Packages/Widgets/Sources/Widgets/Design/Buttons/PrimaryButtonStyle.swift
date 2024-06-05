//
//  PrimaryButtonStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 20/02/2024.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    private let isKeyboardVisible: Bool

    public init(isKeyboardVisible: Bool) {
        self.isKeyboardVisible = isKeyboardVisible
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.keyboardButton)
            .foregroundStyle(Color.white)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(.large)
    }

    private var backgroundColor: Color {
        isEnabled ? .blue : .blueShade2
    }

    private var verticalPadding: CGFloat {
        isKeyboardVisible ? .medium : .large
    }
}
