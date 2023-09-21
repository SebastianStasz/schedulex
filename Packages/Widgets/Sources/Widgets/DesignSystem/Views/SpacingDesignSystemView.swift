//
//  SpacingDesignSystemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

struct SpacingDesignSystemView: View {
    var body: some View {
        DesignSystemView(title: "Spacing") {
            ForEach(Spacing.allCases, id: \.name) { spacing in
                Rectangle()
                    .fill(.grayShade1)
                    .frame(height: spacing.value)
                    .designSystemComponent(name: getName(for: spacing))
            }
        }
    }

    private func getName(for spacing: Spacing) -> String {
        "\(spacing.name) - \(Int(spacing.value))"
    }
}

#Preview {
    SpacingDesignSystemView()
}
