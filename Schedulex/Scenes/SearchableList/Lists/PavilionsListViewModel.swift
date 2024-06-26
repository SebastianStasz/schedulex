//
//  PavilionsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Domain
import Resources
import SchedulexCore
import SchedulexViewModel
import UIKit

final class RoomsListViewController: SwiftUIViewController<PavilionsListViewModel, SearchableListView<Pavilion>> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.pavilionsListTitle
    }
}

struct PavilionsListViewModel: ViewModel {
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> SearchableListStore<Pavilion> {
        let store = SearchableListStore<Pavilion>()
        let errorTracker = DriverSubject<Error>()

        let school = store.viewWillAppear.share()
            .perform(isLoading: store.isLoading, errorTracker: errorTracker) {
                try await context.storage.getCracowUniversityOfEconomicsData()
            }

        CombineLatest(school, store.$searchText)
            .map { $0.0.pavilions.filterUserSearch(text: $0.1) }
            .assign(to: &store.$items)

        store.onSelectListItem
            .sink { navigateToClassroomsList(for: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func navigateToClassroomsList(for pavilion: Pavilion) {
        let viewModel = ClassroomsListViewModel(pavilion: pavilion, navigationController: navigationController)
        let viewController = ClassroomsListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
