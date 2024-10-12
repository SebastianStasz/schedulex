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
    @ObservedObject var store: InfoCardsSectionStore

    var body: some View {
        if !store.infoCards.isEmpty {
            infoCardsView
                .transition(.scale)
        } else if store.showDashboardSwipeTip {
            swipeTip
                .transition(.scale)
        }
    }

    private var infoCardsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .medium) {
                ForEach(store.infoCards) { infoCard in
                    InfoCardView(card: infoCard,
                                 onConfirm: { store.performActionForInfoCard.send(infoCard) },
                                 onClose: { store.closeInfoCard.send(infoCard) })
                        .frame(width: cardWidth)
                }
            }
            .scrollTargetLayoutOrPadding()
        }
        .scrollTargetBehaviorViewAligned()
    }

    private var swipeTip: some View {
        VStack(spacing: .small) {
            Text(L10n.swipeTipTitle, style: .bodyMedium)
            Text(L10n.swipeTipDescription, style: .footnote)
                .foregroundStyle(.grayShade1)
        }
        .padding(.vertical, .xlarge)
    }

    private var cardWidth: CGFloat {
        let factor: CGFloat = store.infoCards.count > 1 ? 3 : 2
        return UIScreen.main.bounds.size.width - factor * .medium
    }
}

private extension View {
    @ViewBuilder
    func scrollTargetBehaviorViewAligned() -> some View {
        if #available(iOS 17.0, *) {
            self.padding(.horizontal, -.medium)
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(.horizontal, .medium, for: .scrollContent)
        } else {
            padding(.horizontal, -.medium)
        }
    }

    @ViewBuilder
    func scrollTargetLayoutOrPadding() -> some View {
        if #available(iOS 17.0, *) {
            scrollTargetLayout()
        } else {
            padding(.horizontal, .medium)
        }
    }
}

#Preview {
    let store = InfoCardsSectionStore()
    return InfoCardsSection(store: store)
}
