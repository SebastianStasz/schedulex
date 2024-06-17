//
//  DashboardViewModel+Navigation.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/01/2024.
//

import Foundation

extension DashboardViewModel {
    enum Destination {
        case settings
        case roomsList
        case teacherGroupsList
        case observedFacultyGroups
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .settings:
            pushSettingsView()
        case .roomsList:
            pushRoomsListView()
        case .teacherGroupsList:
            pushTeacherGroupsList()
        case .observedFacultyGroups:
            pushObservedFacultyGroupsView()
        }
    }

    private func pushSettingsView() {
        let viewModel = SettingsViewModel(notificationsManager: notificationManager, navigationController: navigationController)
        let viewController = SettingsViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    private func pushRoomsListView() {
        let viewModel = PavilionsListViewModel(navigationController: navigationController)
        let viewController = RoomsListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    private func pushTeacherGroupsList() {
        let viewModel = TeacherGroupsListViewModel(navigationController: navigationController)
        let viewController = TeacherGroupsListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    private func pushObservedFacultyGroupsView() {
        let viewModel = ObservedFacultyGroupsViewModel(navigationController: navigationController)
        let viewController = ObservedFacultyGroupsStoreViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
