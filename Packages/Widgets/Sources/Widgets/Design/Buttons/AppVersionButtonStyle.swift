//
//  AppVersionButtonStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import SwiftUI

public struct AppVersionButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.footnoteBig)
            .foregroundStyle(textColor)
            .padding(.vertical, .micro)
            .padding(.horizontal, .small)
            .background(backgroundColor)
            .cornerRadius(.mini)
    }

    private var textColor: Color {
        isEnabled ? .white : .grayShade1
    }

    private var backgroundColor: Color {
        isEnabled ? .greenPrimary : .backgroundSecondary
    }
}
