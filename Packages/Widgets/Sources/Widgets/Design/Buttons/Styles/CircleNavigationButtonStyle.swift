//
//  CircleNavigationButtonStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 16/06/2024.
//

import SwiftUI

struct CircleNavigationButtonStyle: ButtonStyle {
    let icon: Icon
    let showBadge: Bool

    func makeBody(configuration _: Configuration) -> some View {
        Circle()
            .fill(.backgroundTertiary)
            .frame(width: 42, height: 42)
            .overlay {
                Image.icon(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.textPrimary)
                    .padding(3)
                    .overlay(badgeOverlay)
                    .padding(7)
            }
    }

    private var badgeOverlay: some View {
        Circle()
            .fill(.red)
            .frame(width: 9, height: 9)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .opacity(showBadge ? 1 : 0)
    }
}
