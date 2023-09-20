//
//  SchoolViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Domain
import Foundation
import SchedulexFirebase

struct SchoolViewModel: ViewModel {
    func makeStore(storage: FirestoreService) -> SchoolStore {
        let store = SchoolStore()

        let school = store.viewWillAppearForTheFirstTime
            .perform { try await storage.getCracowUniversityOfEconomics() }

        CombineLatest(school, store.$searchText)
            .sink { [weak store] school, searchText in
                store?.faculties = school.faculties.filterUserSearch(text: searchText, by: { $0.name })
                store?.facultyGroups = filterFacultyGroups(faculties: school.faculties, searchText: searchText)
            }
            .store(in: &store.cancellables)

        return store
    }

    private func filterFacultyGroups(faculties: [Faculty], searchText: String) -> [FacultyGroup] {
        guard searchText.count > 1 else { return [] }
        return faculties.flatMap { $0.groups }.filterUserSearch(text: searchText, by: { $0.name })
    }
}
