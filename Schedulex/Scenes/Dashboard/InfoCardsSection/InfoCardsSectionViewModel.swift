//
//  InfoCardsSectionViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 03/02/2024.
//

import Combine
import UIKit
import Widgets
import SchedulexViewModel
import SchedulexCore

final class InfoCardsSectionStore: ObservableObject, CombineHelper {
    var cancellables: Set<AnyCancellable> = []

    @Published fileprivate(set) var infoCards: [InfoCard] = []
    @Published fileprivate(set) var showDashboardSwipeTip = false

    let closeInfoCard = DriverSubject<InfoCard>()
    let performActionForInfoCard = DriverSubject<InfoCard>()
}

@MainActor
struct InfoCardsSectionViewModel {
    let notificationsManager: NotificationsManager

    func makeStore(appData: AppData) -> InfoCardsSectionStore {
        let store = InfoCardsSectionStore()

        CombineLatest(appData.$dashboardSwipeTipPresented, notificationsManager.$areNotificationsSettingsLoaded)
            .map { !$0 && $1 }
            .assign(to: &store.$showDashboardSwipeTip)

        CombineLatest(appData.$hiddenInfoCards, notificationsManager.$canRequestNotificationsAccess)
            .map { getInfoCardsToDisplay(hiddenInfoCards: $0, canRequestNotificationsAccess: $1) }
            .assign(to: &store.$infoCards)

        store.performActionForInfoCard
            .perform { await performActionForInfoCard($0, appData: appData) }
            .sinkAndStore(on: store) { _, _ in }

        store.closeInfoCard
            .sink { appData.hideInfoCard($0) }
            .store(in: &store.cancellables)

        return store
    }

    private func performActionForInfoCard(_ infoCard: InfoCard, appData: AppData) async {
        switch infoCard {
        case .enableNotifications:
            appData.classNotificationsEnabled = true
            try? await notificationsManager.requestNotificationsPermission()
        case .rateTheApplication:
            UIApplication.shared.openAppInAppStore()
            appData.hideInfoCard(infoCard)
        }
    }

    private func getInfoCardsToDisplay(hiddenInfoCards: [InfoCard], canRequestNotificationsAccess: Bool) -> [InfoCard] {
        InfoCard.allCases.filter {
            if hiddenInfoCards.contains($0) {
                return false
            }
            switch $0 {
            case .enableNotifications:
                return canRequestNotificationsAccess
            case .rateTheApplication:
                return shouldRateAppInfoCardBeDisplayed()
            }
        }
    }

    private func shouldRateAppInfoCardBeDisplayed() -> Bool {
        guard let pathToDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.path(),
              let installDate = try? FileManager.default.attributesOfItem(atPath: pathToDocumentsFolder)[.creationDate] as? Date,
              let daysFromInstallation = Calendar.current.dateComponents([.day], from: installDate, to: .now).day
        else { return false }
        return daysFromInstallation > 7
    }
}
