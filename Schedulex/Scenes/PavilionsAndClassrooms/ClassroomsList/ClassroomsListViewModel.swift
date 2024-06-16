//
//  ClassroomsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Combine
import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class ClassroomsListStore: RootStore {
    @Published fileprivate(set) var classrooms: [Classroom] = []
    @Published var searchText = ""

    let navigateToEventsListView = DriverSubject<Classroom>()
}

struct ClassroomsListViewModel: ViewModel {
    let pavilion: Pavilion
    var navigationController: UINavigationController?

    func makeStore(context _: Context) -> ClassroomsListStore {
        let store = ClassroomsListStore()

        CombineLatest(Just(pavilion.classrooms), store.$searchText)
            .map { $0.0.filterUserSearch(text: $0.1) }
            .assign(to: &store.$classrooms)

        store.navigateToEventsListView
            .sink { navigateToEventsListView(classroom: $0) }
            .store(in: &store.cancellables)

        return store
    }

    private func navigateToEventsListView(classroom: Classroom) {
        pushEventsListView(input: .classroom(classroom))
    }
}
