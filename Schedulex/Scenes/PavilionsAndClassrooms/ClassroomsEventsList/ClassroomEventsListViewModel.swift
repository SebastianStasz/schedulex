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
    let classroomName: String
    @Published fileprivate(set) var events: [Event] = []

    let isLoading = DriverState(true)

    init(classroomName: String) {
        self.classroomName = classroomName
    }
}

struct ClassroomEventsListViewModel: ViewModel {
    let classroom: Classroom
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> ClassroomEventsListStore {
        let store = ClassroomEventsListStore(classroomName: classroom.name)
        let service = UekScheduleService()

        store.viewWillAppear
            .perform(isLoading: store.isLoading) {
                try await service.getEvents(from: classroom.classroomUrl)
            }
            .assign(to: &store.$events)

        return store
    }
}
