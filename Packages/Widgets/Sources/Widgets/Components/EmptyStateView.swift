//
//  EmptyStateView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 25/06/2024.
//

import Resources
import SwiftUI

public struct EmptyStateView: View {
    @Environment(\.colorScheme) private var colorScheme

    public init() {}

    public var body: some View {
        VStack(spacing: .xlarge) {
            Image.emptyStateCat
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.grayShade1)
                .frame(width: 100)
                .opacity(imageOpacity)

            VStack(spacing: .micro) {
                Text(L10n.listEmptyStateTitle, style: .titleSmall)
                    .foregroundStyle(.textPrimary)

                Text(L10n.listEmptyStateDescription, style: .body)
                    .foregroundStyle(.grayShade1)
            }
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, .xlarge)
    }

    private var imageOpacity: Double {
        colorScheme == .dark ? 0.75 : 0.9
    }
}

#Preview {
    EmptyStateView()
}
