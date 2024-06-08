//
//  ClassRoomsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Combine
import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class ClassRoomsListStore: RootStore {
    @Published fileprivate(set) var classrooms: [Classroom] = []
    @Published var searchText = ""
}

struct ClassRoomsListViewModel: ViewModel {
    let pavilion: Pavilion
    var navigationController: UINavigationController?

    func makeStore(context _: Context) -> ClassRoomsListStore {
        let store = ClassRoomsListStore()

        CombineLatest(Just(pavilion.classrooms), store.$searchText)
            .map { $0.0.filterUserSearch(text: $0.1) }
            .assign(to: &store.$classrooms)

        return store
    }
}
