//
//  TeachersListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 17/06/2024.
//

import Combine
import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class TeachersListStore: RootStore {
    @Published fileprivate(set) var teachers: [Teacher] = []
    @Published var searchText = ""

    let navigateToEventsListView = DriverSubject<Teacher>()
}

struct TeachersListViewModel: ViewModel {
    let teacherGroup: TeacherGroup
    var navigationController: UINavigationController?

    func makeStore(context _: Context) -> TeachersListStore {
        let store = TeachersListStore()

        CombineLatest(Just(teacherGroup.teachers), store.$searchText)
            .map { $0.0.filterUserSearch(text: $0.1) }
            .assign(to: &store.$teachers)

        store.navigateToEventsListView
            .sink { navigateToEventsListView(teacher: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func navigateToEventsListView(teacher: Teacher) {
        pushEventsListView(input: .teacher(teacher))
    }
}
