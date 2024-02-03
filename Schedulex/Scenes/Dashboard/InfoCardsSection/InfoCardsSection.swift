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
    @AppStorage("classNotificationsEnabled") private var classNotificationsEnabled = false
    @AppStorage("showDashboardSwipeTip") private var showDashboardSwipeTip = true

    @ObservedObject var store: InfoCardsSectionStore

    var body: some View {
        if !store.infoCards.isEmpty {
            infoCardsView
                .transition(.scale)
        } 
    }
    
    private var infoCardsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .medium) {
                ForEach(store.infoCards) { infoCard in
                    InfoCardView(card: infoCard, 
                                 onConfirm: { performInfoCardAction(for: infoCard) },
                                 onClose: { store.closeInfoCard.send(infoCard) })
                    .frame(width: cardWidth)
                }
            }
            .padding(.horizontal, .medium)
        }
        .padding(.horizontal, -.medium)
    }

    private var cardWidth: CGFloat {
        let factor: CGFloat = store.infoCards.count > 1 ? 3 : 2
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

    private func performInfoCardAction(for infoCard: InfoCard) {
//        switch infoCard {
//        case .enableNotifications:
//            classNotificationsEnabled = true
////            Task { try? await notificationsManager.requestNotificationsPermission() }
//        case .rateTheApplication:
//            openAppInAppStore()
//            hiddenInfoCards.append(.rateTheApplication)
//        }
    }

    private func openAppInAppStore() {
        let url = URL(string: "itms-apps://itunes.apple.com/app/id6468822571")!
        UIApplication.shared.open(url)
    }
}

#Preview {
    let store = InfoCardsSectionStore()
    return InfoCardsSection(store: store)
}
