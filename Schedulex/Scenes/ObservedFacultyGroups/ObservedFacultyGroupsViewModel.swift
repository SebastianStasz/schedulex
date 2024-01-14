//
//  ObservedFacultyGroupsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Domain
import SwiftUI
import SchedulexFirebase

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

        context.$appData
            .map { $0.subscribedFacultyGroups }
            .assign(to: &store.$subscribedGroups)

        store.presentFacultiesList
            .sink { _ in presentFacultiesList() }
            .store(in: &store.cancellables)

        store.editFacultyGroup
            .sink { presentEditFacultyGroupView(facultyGroup: $0) }
            .store(in: &store.cancellables)

        store.toggleFacultyGroupVisibility
            .sink { context.appData.toggleFacultyGroupVisibility($0) }
            .store(in: &store.cancellables)

        store.deleteFacultyGroup
            .sinkAndStore(on: store) { store, _ in
                guard let groupToDelete = store.groupToDelete else { return }
                context.appData.deleteFacultyGroup(groupToDelete)
                store.groupToDelete = nil
            }

        return store
    }

    private func presentFacultiesList() {
        let viewController = UIHostingController(rootView: FacultiesListView(service: FirestoreService()))
        navigationController?.presentModally(viewController)
    }

    private func presentEditFacultyGroupView(facultyGroup: FacultyGroup) {
        let viewController = UIHostingController(rootView: FacultyGroupDetailsView(facultyGroup: facultyGroup, type: .editable))
        navigationController?.presentModally(viewController)
    }
}
