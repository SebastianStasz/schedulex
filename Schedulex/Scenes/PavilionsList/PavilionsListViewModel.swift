//
//  PavilionsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class PavilionsListStore: RootStore {
    @Published fileprivate(set) var pavilions: [Pavilion] = []
    @Published var searchText = ""

    let isLoading = DriverState(true)
}

struct PavilionsListViewModel: ViewModel {
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> PavilionsListStore {
        let store = PavilionsListStore()
        let errorTracker = DriverSubject<Error>()

        let school = store.viewWillAppear.share()
            .perform(isLoading: store.isLoading, errorTracker: errorTracker) {
                try await context.storage.getCracowUniversityOfEconomicsData()
            }

        CombineLatest(school, store.$searchText)
            .map { mapToPavilions($0.pavilions, searchText: $1) }
            .assign(to: &store.$pavilions)

        return store
    }

    private func mapToPavilions(_ pavilions: [Pavilion], searchText: String) -> [Pavilion] {
        pavilions
            .filterUserSearch(text: searchText, by: { $0.pavilion })
            .sorted(by: { $0.pavilion < $1.pavilion })
    }
}
