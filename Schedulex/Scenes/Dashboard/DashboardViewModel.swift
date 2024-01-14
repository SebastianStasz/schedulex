//
//  DashboardViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import UIKit

final class DashboardStore: RootStore {
    let pushObservedFacultyGroupsView = DriverSubject<Void>()
}

struct DashboardViewModel: ViewModel {
    weak var navigationController: UINavigationController?

    func makeStore(context: Context) -> DashboardStore {
        let store = DashboardStore()

        store.pushObservedFacultyGroupsView
            .sink { pusObservedFacultyGroupsView() }
            .store(in: &store.cancellables)

        return store
    }

    private func pusObservedFacultyGroupsView() {
        let viewModel = ObservedFacultyGroupsViewModel(navigationController: navigationController)
        let viewController = ObservedFacultyGroupsStoreViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
