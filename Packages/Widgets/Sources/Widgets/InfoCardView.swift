//
//  InfoCardView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 29/11/2023.
//

import SwiftUI

public struct InfoCardView: View {
    private let card: InfoCard

    public init(card: InfoCard) {
        self.card = card
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
                    HStack(spacing: 0) {
                        Text(card.title, style: .body)
                            .foregroundColor(.textDark)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Image.icon(.closeButton)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17, alignment: .top)
                            .fontWeight(.light)
                            .foregroundColor(.textSecondary)
                    }

                    Text(card.message, style: .footnote)
                        .foregroundColor(.textSecondary)
                }
            }

            Rectangle()
                .fill(Color.black)
                .frame(height: 1)
                .opacity(0.1)
                .padding(.vertical, .large)

            Text("Włącz powiadomienia", style: .body)
                .foregroundColor(.textDark)
                .frame(maxWidth: .infinity)
        }
        .padding(.large)
        .background(Color.yellowPrimary)
        .cornerRadius(.medium)
    }
}

#Preview {
    InfoCardView(card: .enableNotifications)
}
