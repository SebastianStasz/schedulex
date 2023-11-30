//
//  DoubleNavigationTitle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import SwiftUI

private struct DoubleNavigationTitle: ViewModifier {
    let title: String
    let subtitle: String
    let showSettings: () -> Void

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

                Button("Settings", systemImage: "gearshape", action: showSettings)
                    .labelStyle(.iconOnly)
                    .font(.title2)
                    .foregroundStyle(.textPrimary)
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
    func doubleNavigationTitle(title: String, subtitle: String, showSettings: @escaping () -> Void) -> some View {
        modifier(DoubleNavigationTitle(title: title, subtitle: subtitle, showSettings: showSettings))
    }
}

#Preview {
    Text("Content", style: .body)
        .frame(maxHeight: .infinity)
        .doubleNavigationTitle(title: "30 listopada 2023", subtitle: "Dzisiaj", showSettings: {})
}

private extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
