//
//  ObservedFacultyGroupsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Domain
import SchedulexCore
import SchedulexFirebase
import SchedulexViewModel
import SwiftUI

final class ObservedFacultyGroupsStore: RootStore {
    @Published fileprivate(set) var subscribedGroups: [FacultyGroup] = []
    @Published var groupToDelete: FacultyGroup?

    let presentFacultiesList = DriverSubject<Void>()
    let deleteFacultyGroup = DriverSubject<Void>()
    let editFacultyGroup = DriverSubject<FacultyGroup>()
    let toggleFacultyGroupVisibility = DriverSubject<FacultyGroup>()

    var isGroupDeleteConfirmationPresented: Binding<Bool> {
        Binding(get: { self.groupToDelete != nil }, set: { _ in self.groupToDelete = nil })
    }
}

struct ObservedFacultyGroupsViewModel: ViewModel {
    weak var navigationController: UINavigationController?

    func makeStore(context: Context) -> ObservedFacultyGroupsStore {
        let store = ObservedFacultyGroupsStore()

        context.appData.$subscribedFacultyGroups
            .assign(to: &store.$subscribedGroups)

        store.presentFacultiesList
            .sink(on: store) { _ in presentFacultiesList() }

        store.editFacultyGroup
            .sink(on: store) { pushFacultyGroupDetailsView($0, viewType: .editable) }

        store.toggleFacultyGroupVisibility
            .sink(on: store) { context.appData.toggleFacultyGroupVisibility($0) }

        store.deleteFacultyGroup
            .sink(on: store) {
                guard let groupToDelete = $0.groupToDelete else { return }
                context.appData.unsubscribeFacultyGroup(groupToDelete)
                $0.groupToDelete = nil
            }

        return store
    }

    private func presentFacultiesList() {
        let navigationController = UINavigationController()
        let viewModel = FacultiesListViewModel(navigationController: navigationController)
        let viewController = FacultiesListViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController?.presentFullScreen(navigationController)
    }
}
