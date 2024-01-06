//
//  CustomButtonStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import SwiftUI

public enum CustomButtonStyle {
    case appVersionButtonStyle
}

public extension Button {
    func buttonStyle(_ style: CustomButtonStyle) -> some View {
        switch style {
        case .appVersionButtonStyle:
            let style = AppVersionButtonStyle()
            return self.buttonStyle(style)
        }
    }
}
