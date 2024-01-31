//
//  DashboardViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import UIKit

final class DashboardStore: RootStore {
    let navigateToObservedFacultyGroupsView = DriverSubject<Void>()
    let navigateToSettings = DriverSubject<Void>()
}

struct DashboardViewModel: ViewModel {
    weak var navigationController: UINavigationController?

    func makeStore(context: Context) -> DashboardStore {
        let store = DashboardStore()

        store.navigateToSettings
            .sink { pushSettingsView() }
            .store(in: &store.cancellables)

        store.navigateToObservedFacultyGroupsView
            .sink { pusObservedFacultyGroupsView() }
            .store(in: &store.cancellables)

        return store
    }

    let manager = NotificationsManager()

    private func pushSettingsView() {
        let viewModel = SettingsViewModel(notificationsManager: manager, navigationController: navigationController)
        let viewController = SettingsViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    private func pusObservedFacultyGroupsView() {
        let viewModel = ObservedFacultyGroupsViewModel(navigationController: navigationController)
        let viewController = ObservedFacultyGroupsStoreViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
