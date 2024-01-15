//
//  FacultiesListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Domain
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

        let school = store.viewWillAppear.share()
            .perform(isLoading: store.isLoading) {
                try await context.firestoreService.getCracowUniversityOfEconomics()
            }

        CombineLatest(school, store.$searchText)
            .map { mapToFaculties($0.faculties, searchText: $1) }
            .assign(to: &store.$faculties)

        CombineLatest(school, store.$searchText)
            .map { mapToFacultyGroups($0.faculties, searchText: $1) }
            .assign(to: &store.$facultyGroups)

        store.navigateToFacultyGroupList
            .sink { pushFacultyGroupList(for: $0) }
            .store(in: &store.cancellables)

        store.navigateToFacultyGroupDetails
            .sink { pushFacultyGroupDetailsView($0) }
            .store(in: &store.cancellables)

        return store
    }

    private func mapToFaculties(_ faculties: [Faculty], searchText: String) -> [Faculty] {
        faculties
            .filterUserSearch(text: searchText, by: { $0.name })
            .sorted(by: { $0.name < $1.name })
    }

    private func mapToFacultyGroups(_ faculties: [Faculty], searchText: String) -> [FacultyGroup] {
        guard searchText.count > 1 else { return [] }
        return faculties
            .flatMap { $0.groups }
            .filterUserSearch(text: searchText, by: { $0.name })
            .sorted(by: { $0.name < $1.name })
    }

    private func pushFacultyGroupList(for faculty: Faculty) {
        let viewModel = FacultyGroupListViewModel(navigationController: navigationController, faculty: faculty)
        let viewController = FacultyGroupListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
