//
//  DoubleNavigationTitle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import Resources
import SwiftUI

private struct DoubleNavigationTitle: ViewModifier {
    let title: String
    let subtitle: String
    let showBadge: Bool
    let openSettings: () -> Void
    let openRoomsList: () -> Void

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.backgroundSecondary)
                .frame(height: topSpacing)

            HStack(spacing: .xlarge) {
                VStack(alignment: .leading, spacing: .micro) {
                    Text(subtitle, style: .body)
                        .foregroundStyle(.grayShade1)

                    Text(title, style: .titleSmall)
                        .foregroundStyle(.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: .medium) {
                    Button(L10n.pavilionsListTitle, action: openRoomsList)
                        .buttonStyle(.circleNavigationButtonStyle(icon: .pavilionsList))

                    Button(L10n.settingsTitle, action: openSettings)
                        .buttonStyle(.circleNavigationButtonStyle(icon: .settings, showBadge: showBadge))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, .medium)
            .background(.backgroundSecondary)

            content
        }
        .ignoresSafeArea(edges: .top)
    }

    private var topSpacing: CGFloat {
        UIDevice.current.hasNotch ? 72 : 40
    }
}

public extension View {
    func doubleNavigationTitle(title: String, subtitle: String, showBadge: Bool, openSettings: @escaping () -> Void, openRoomsList: @escaping () -> Void) -> some View {
        modifier(DoubleNavigationTitle(title: title, subtitle: subtitle, showBadge: showBadge, openSettings: openSettings, openRoomsList: openRoomsList))
    }
}

#Preview {
    Text("Content", style: .body)
        .frame(maxHeight: .infinity)
        .doubleNavigationTitle(title: "30 listopada 2023", subtitle: "Dzisiaj", showBadge: false, openSettings: {}, openRoomsList: {})
}
