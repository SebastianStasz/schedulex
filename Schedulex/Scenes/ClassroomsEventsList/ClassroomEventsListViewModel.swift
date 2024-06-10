//
//  ClassroomEventsListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 10/06/2024.
//

import Domain
import UIKit
import SchedulexCore
import SchedulexViewModel
import UEKScraper

final class ClassroomEventsListStore: RootStore {
    @Published fileprivate(set) var events: [Event] = []

    let isLoading = DriverState(true)
}

struct ClassroomEventsListViewModel: ViewModel {
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> ClassroomEventsListStore {
        let store = ClassroomEventsListStore()
        let service = UekScheduleService()

        store.viewWillAppear
            .perform(isLoading: store.isLoading) {

            }

        return store
    }
}
