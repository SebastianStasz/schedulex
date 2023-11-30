//
//  InfoCardsSection.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/11/2023.
//

import Resources
import SwiftUI
import Widgets

struct InfoCardsSection: View {
    @AppStorage("showDashboardSwipeTip") private var showDashboardSwipeTip = true
    @AppStorage("hiddenInfoCards") private var hiddenInfoCards: [InfoCard] = []

    var body: some View {
        if !infoCards.isEmpty {
            infoCardsView
                .transition(.scale)
        } else if showDashboardSwipeTip {
            swipeTip
                .transition(.scale)
        }
    }
    
    private var infoCardsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .medium) {
                ForEach(infoCards) { infoCard in
                    InfoCardView(card: infoCard, onClose: {
                        hiddenInfoCards.append(infoCard)
                    })
                    .frame(width: cardWidth)
                }
            }
            .padding(.horizontal, .medium)
        }
        .padding(.horizontal, -.medium)
    }

    private var infoCards: [InfoCard] {
        InfoCard.allCases.filter { !hiddenInfoCards.contains($0) }
    }

    private var cardWidth: CGFloat {
        let factor: CGFloat = infoCards.count > 1 ? 3 : 2
        return UIScreen.main.bounds.size.width - factor * .medium
    }

    private var swipeTip: some View {
        VStack(spacing: .small) {
            Text(L10n.swipeTipTitle, style: .bodyMedium)
            Text(L10n.swipeTipDescription, style: .footnote)
                .foregroundStyle(.grayShade1)
        }
        .padding(.vertical, .xlarge)
    }
}

#Preview {
    InfoCardsSection()
}
