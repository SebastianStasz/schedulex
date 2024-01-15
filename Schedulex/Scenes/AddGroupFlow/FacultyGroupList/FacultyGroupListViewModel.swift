//
//  FacultyGroupListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Domain
import Foundation

final class FacultyGroupListStore: RootStore {
    @Published fileprivate(set) var facultyGroups: [FacultyGroup] = []

    @Published var searchText = ""

    let navigateToFacultyGroupDetails = DriverSubject<FacultyGroup>()
}

struct FacultyGroupListViewModel: ViewModel {
    let faculty: Faculty

    func makeStore(context: Context) -> FacultyGroupListStore {
        let store = FacultyGroupListStore()

        store.$searchText
            .map { faculty.groups.filterUserSearch(text: $0, by: { $0.name }) }
            .assign(to: &store.$facultyGroups)

        store.navigateToFacultyGroupDetails
            .sink { pushFacultyGroupDetailsView($0) }
            .store(in: &store.cancellables)

        return store
    }

    private func pushFacultyGroupDetailsView(_ facultyGroup: FacultyGroup) {

    }
}
