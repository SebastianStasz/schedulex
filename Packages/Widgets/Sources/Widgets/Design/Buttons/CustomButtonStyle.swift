//
//  CustomButtonStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import SwiftUI

public enum CustomButtonStyle {
    case appVersionButtonStyle
    case primaryButtonStyle(isKeyboardVisible: Bool)
}

public extension Button {
    @ViewBuilder
    func buttonStyle(_ style: CustomButtonStyle) -> some View {
        switch style {
        case .appVersionButtonStyle:
            let style = AppVersionButtonStyle()
            self.buttonStyle(style)
        case let .primaryButtonStyle(isKeyboardVisible):
            let style = PrimaryButtonStyle(isKeyboardVisible: isKeyboardVisible)
            self.buttonStyle(style)
        }
    }
}
