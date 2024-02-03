//
//  InfoCardsSectionViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 03/02/2024.
//

import Combine
import Foundation
import Widgets

final class InfoCardsSectionStore: ObservableObject {
    var cancellables: Set<AnyCancellable> = []

    @Published fileprivate(set) var infoCards: [InfoCard] = []

    let closeInfoCard = DriverSubject<InfoCard>()
    let performActionForInfoCard = DriverSubject<InfoCard>()
}

@MainActor
struct InfoCardsSectionViewModel {
    let notificationsManager: NotificationsManager

    func makeStore(context: Context) -> InfoCardsSectionStore {
        let store = InfoCardsSectionStore()

        CombineLatest(context.appData.$hiddenInfoCards, notificationsManager.$canRequestNotificationsAccess)
            .map { getInfoCardsToDisplay(hiddenInfoCards: $0, canRequestNotificationsAccess: $1) }
            .assign(to: &store.$infoCards)

        store.closeInfoCard
            .sink { context.appData.hideInfoCard($0) }
            .store(in: &store.cancellables)

        return store
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
