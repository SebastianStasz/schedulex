//
//  ClassroomsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Combine
import Domain
import Resources
import SchedulexCore
import SchedulexViewModel
import UIKit

final class ClassroomsListViewController: SwiftUIViewController<ClassroomsListViewModel, SearchableListView<Classroom>> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.pavilion.name
    }
}

struct ClassroomsListViewModel: ViewModel {
    let pavilion: Pavilion
    var navigationController: UINavigationController?

    func makeStore(context _: Context) -> SearchableListStore<Classroom> {
        let store = SearchableListStore<Classroom>()

        CombineLatest(Just(pavilion.classrooms), store.$searchText)
            .map { $0.0.filterUserSearch(text: $0.1) }
            .assign(to: &store.$items)

        store.onSelectListItem
            .sink(on: store) { navigateToEventsListView(classroom: $0) }

        return store
    }

    private func navigateToEventsListView(classroom: Classroom) {
        pushEventsListView(input: .classroom(classroom))
    }
}
