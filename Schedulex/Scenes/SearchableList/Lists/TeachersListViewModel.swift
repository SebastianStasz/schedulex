//
//  TeachersListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 17/06/2024.
//

import Combine
import Domain
import Resources
import SchedulexCore
import SchedulexViewModel
import UIKit

final class TeachersListViewController: SwiftUIViewController<TeachersListViewModel, SearchableListView<Teacher>> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.teachersListTitle
    }
}

struct TeachersListViewModel: ViewModel {
    let teacherGroup: TeacherGroup
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> SearchableListStore<Teacher> {
        let store = SearchableListStore<Teacher>()

        CombineLatest(Just(teacherGroup.teachers), store.$searchText)
            .map { $0.0.filterUserSearch(text: $0.1) }
            .assign(to: &store.$items)

        store.onSelectListItem
            .sink { navigateToEventsListView(teacher: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func navigateToEventsListView(teacher: Teacher) {
        pushEventsListView(input: .teacher(teacher))
    }
}
