//
//  FacultiesListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class FacultiesListStore: RootStore {
    @Published fileprivate(set) var faculties: [Faculty] = []
    @Published fileprivate(set) var facultyGroups: [FacultyGroup] = []
    @Published var searchText = ""

    let isLoading = DriverState(true)
    let navigateToFacultyGroupList = DriverSubject<Faculty>()
    let navigateToFacultyGroupDetails = DriverSubject<FacultyGroup>()
}

struct FacultiesListViewModel: ViewModel {
    weak var navigationController: UINavigationController?

    func makeStore(context: Context) -> FacultiesListStore {
        let store = FacultiesListStore()
        let errorTracker = DriverSubject<Error>()

        let school = store.viewWillAppear.share()
            .perform(isLoading: store.isLoading, errorTracker: errorTracker) {
                try await context.storage.getCracowUniversityOfEconomicsData()
            }

        CombineLatest(school, store.$searchText)
            .map { $0.0.faculties.filterUserSearch(text: $0.1) }
            .assign(to: &store.$faculties)

        CombineLatest(school, store.$searchText)
            .map { mapToFacultyGroups($0.faculties, searchText: $1) }
            .assign(to: &store.$facultyGroups)

        store.navigateToFacultyGroupList
            .sink { pushFacultyGroupList(for: $0) }
            .store(in: &store.cancellables)

        store.navigateToFacultyGroupDetails
            .sink { pushFacultyGroupDetailsView($0, viewType: .preview) }
            .store(in: &store.cancellables)

        return store
    }

    private func mapToFacultyGroups(_ faculties: [Faculty], searchText: String) -> [FacultyGroup] {
        guard searchText.count > 1 else { return [] }
        return faculties
            .flatMap { $0.groups }
            .filterByNameAndSort(text: searchText)
    }

    private func pushFacultyGroupList(for faculty: Faculty) {
        let viewModel = FacultyGroupListViewModel(navigationController: navigationController, faculty: faculty)
        let viewController = FacultyGroupListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
