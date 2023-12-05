//
//  InfoCardView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 29/11/2023.
//

import SwiftUI

public struct InfoCardView: View {
    private let card: InfoCard
    private let onConfirm: () -> Void
    private let onClose: () -> Void

    public init(card: InfoCard, onConfirm: @escaping () -> Void, onClose: @escaping () -> Void) {
        self.card = card
        self.onConfirm = onConfirm
        self.onClose = onClose
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: .medium) {
                Image.icon(.info)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17, alignment: .top)
                    .fontWeight(.light)
                    .foregroundColor(.textDark)

                VStack(alignment: .leading, spacing: .small) {
                    Text(card.title, style: .body)
                        .foregroundColor(.textDark)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(card.message, style: .footnote)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.textSecondary)
                }

                Button(action: onClose) {
                    Image.icon(.closeButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14, alignment: .top)
                        .fontWeight(.light)
                        .foregroundColor(.textSecondary)
                }
                .buttonStyle(.plain)
            }

            Rectangle()
                .fill(Color.black)
                .frame(height: 1)
                .opacity(0.1)
                .padding(.vertical, .large)

            Button(action: onConfirm) {
                Text(card.buttonTitle, style: .body)
                    .foregroundColor(.textDark)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .padding(.large)
        .background(Color.yellowPrimary)
        .cornerRadius(.medium)
    }
}

#Preview {
    InfoCardView(card: .enableNotifications, onConfirm: {}, onClose: {})
        .padding(.large)
}
