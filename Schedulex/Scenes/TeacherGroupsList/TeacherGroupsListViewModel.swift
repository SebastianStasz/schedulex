//
//  TeacherGroupsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 16/06/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class TeacherGroupsListStore: RootStore {
    @Published fileprivate(set) var teacherGroups: [TeacherGroup] = []
    @Published var searchText = ""

    let isLoading = DriverState(true)
    let navigateToTeachersList = DriverSubject<TeacherGroup>()
}

struct TeacherGroupsListViewModel: ViewModel {
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> TeacherGroupsListStore {
        let store = TeacherGroupsListStore()
        let errorTracker = DriverSubject<Error>()

        let school = store.viewWillAppear.share()
            .perform(isLoading: store.isLoading, errorTracker: errorTracker) {
                try await context.storage.getCracowUniversityOfEconomicsData()
            }

        CombineLatest(school, store.$searchText)
            .map { $0.0.teacherGroups.filterUserSearch(text: $0.1) }
            .assign(to: &store.$teacherGroups)

        store.navigateToTeachersList
            .sink { navigateToTeachersList(for: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func navigateToTeachersList(for teacherGroup: TeacherGroup) {
        let viewModel = TeachersListViewModel(teacherGroup: teacherGroup, navigationController: navigationController)
        let viewController = TeachersListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
