//
//  FacultyGroupListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class FacultyGroupListStore: RootStore {
    @Published fileprivate(set) var facultyGroups: [FacultyGroup] = []

    @Published var searchText = ""

    let navigateToFacultyGroupDetails = DriverSubject<FacultyGroup>()
}

struct FacultyGroupListViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let faculty: Faculty

    func makeStore(context _: Context) -> FacultyGroupListStore {
        let store = FacultyGroupListStore()

        store.$searchText
            .map { faculty.groups.filterByNameAndSort(text: $0) }
            .assign(to: &store.$facultyGroups)

        store.navigateToFacultyGroupDetails
            .sink { pushFacultyGroupDetailsView($0, viewType: .preview) }
            .store(in: &store.cancellables)

        return store
    }
}
