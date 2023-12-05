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
    @EnvironmentObject private var notificationsManager: NotificationsManager
    @AppStorage("classNotificationsEnabled") private var classNotificationsEnabled = false
    @AppStorage("showDashboardSwipeTip") private var showDashboardSwipeTip = true
    @AppStorage("hiddenInfoCards") private var hiddenInfoCards: [InfoCard] = []

    var body: some View {
        if !infoCardsToDisplay.isEmpty {
            infoCardsView
                .transition(.scale)
        } else if showDashboardSwipeTip, notificationsManager.areNotificationsSettingsLoaded {
            swipeTip
                .transition(.scale)
        }
    }
    
    private var infoCardsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .medium) {
                ForEach(infoCardsToDisplay) { infoCard in
                    InfoCardView(card: infoCard, onConfirm: {
                        performInfoCardAction(for: infoCard)
                    }, onClose: {
                        hiddenInfoCards.append(infoCard)
                    })
                    .frame(width: cardWidth)
                }
            }
            .padding(.horizontal, .medium)
        }
        .padding(.horizontal, -.medium)
    }

    private var cardWidth: CGFloat {
        let factor: CGFloat = infoCardsToDisplay.count > 1 ? 3 : 2
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

    private var infoCardsToDisplay: [InfoCard] {
        InfoCard.allCases.filter { shouldBeDisplayed(infoCard: $0) }
    }

    private func shouldBeDisplayed(infoCard: InfoCard) -> Bool {
        guard !hiddenInfoCards.contains(infoCard) else {
            return false
        }
        switch infoCard {
        case .enableNotifications:
            return notificationsManager.canRequestNotificationsAccess ?? false
        }
    }

    private func performInfoCardAction(for infoCard: InfoCard) {
        switch infoCard {
        case .enableNotifications:
            classNotificationsEnabled = true
            Task { try? await notificationsManager.requestNotificationsPermission() }
        }
    }
}

#Preview {
    InfoCardsSection()
        .environmentObject(NotificationsManager())
}
