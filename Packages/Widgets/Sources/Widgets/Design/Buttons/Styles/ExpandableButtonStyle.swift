//
//  ExpandableButtonStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 15/09/2024.
//

import SwiftUI

struct ExpandableButtonStyle: ButtonStyle {
    var icon: Icon?
    var fillMaxWidth = true
    var isExpanded = false

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .small) {
            if let icon {
                Image.icon(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.textTertiary)
                    .frame(width: 20, height: 20)
            }

            if isExpanded {
                configuration.label
                    .font(.bodyMedium)
                    .foregroundStyle(.textTertiary)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .padding(.medium)
        .frame(maxWidth: .infinity)
        .background(.grayShade2)
        .cornerRadius(100)
        .fixedSize(horizontal: !fillMaxWidth, vertical: false)
    }
}
