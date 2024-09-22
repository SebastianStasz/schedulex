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
    case circleNavigationButtonStyle(icon: Icon, showBadge: Bool = false)
    case expandableButtonStyle(icon: Icon? = nil, fillMaxWidth: Bool = false, isExpanded: Bool = false)
}

public extension Button {
    @ViewBuilder
    func buttonStyle(_ style: CustomButtonStyle) -> some View {
        switch style {
        case .appVersionButtonStyle:
            buttonStyle(AppVersionButtonStyle())
        case let .primaryButtonStyle(isKeyboardVisible):
            buttonStyle(PrimaryButtonStyle(isKeyboardVisible: isKeyboardVisible))
        case let .circleNavigationButtonStyle(icon, showBadge):
            buttonStyle(CircleNavigationButtonStyle(icon: icon, showBadge: showBadge))
        case let .expandableButtonStyle(icon, fillMaxWidth, isExpanded):
            buttonStyle(ExpandableButtonStyle(icon: icon, fillMaxWidth: fillMaxWidth, isExpanded: isExpanded))
        }
    }
}
