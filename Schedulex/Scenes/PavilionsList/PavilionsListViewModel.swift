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
    let navigateToClassroomsListForPavilion = DriverSubject<Pavilion>()
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
            .map { $0.0.pavilions.filterUserSearch(text: $0.1) }
            .assign(to: &store.$pavilions)

        store.navigateToClassroomsListForPavilion
            .sink { navigateToClassroomsList(for: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func navigateToClassroomsList(for pavilion: Pavilion) {
        let viewModel = ClassRoomsListViewModel(pavilion: pavilion)
        let viewController = ClassRoomsListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
