//
//  TeacherGroupsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 16/06/2024.
//

import Domain
import Resources
import SchedulexCore
import SchedulexViewModel
import UIKit

final class TeacherGroupsListViewController: SwiftUIViewController<TeacherGroupsListViewModel, SearchableListView<TeacherGroup>> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.teachersListTitle
    }
}

struct TeacherGroupsListViewModel: ViewModel {
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> SearchableListStore<TeacherGroup> {
        let store = SearchableListStore<TeacherGroup>()
        let errorTracker = DriverSubject<Error>()

        let school = store.viewWillAppear.share()
            .perform(isLoading: store.isLoading, errorTracker: errorTracker) {
                try await context.storage.getCracowUniversityOfEconomicsData()
            }

        CombineLatest(school, store.$searchText)
            .map { $0.0.teacherGroups.filterUserSearch(text: $0.1) }
            .assign(to: &store.$items)

        store.onSelectListItem
            .sink(on: store) { navigateToTeachersList(for: $0) }

        return store
    }

    private func navigateToTeachersList(for teacherGroup: TeacherGroup) {
        let viewModel = TeachersListViewModel(teacherGroup: teacherGroup, navigationController: navigationController)
        let viewController = TeachersListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
