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

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.backgroundSecondary)
                .frame(height: 72)

            HStack(spacing: .xlarge) {
                VStack(alignment: .leading, spacing: .micro) {
                    Text(subtitle, style: .body)
                        .foregroundStyle(.grayShade1)

                    Text(title, style: .titleSmall)
                        .foregroundStyle(.textPrimary)
                }
                
                SwiftUI.Text("🐥")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, .medium)
            .background(.backgroundSecondary)

            content
        }
        .ignoresSafeArea(edges: .top)
    }
}

public extension View {
    func doubleNavigationTitle(title: String, subtitle: String) -> some View {
        modifier(DoubleNavigationTitle(title: title, subtitle: subtitle))
    }
}

#Preview {
    Text("Content", style: .body)
        .doubleNavigationTitle(title: "Title", subtitle: "Note")
}
