//
//  FacultyGroupClassListViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class FacultyGroupClassListStore: RootStore {
    let viewType: FacultyGroupDetailsViewType

    @Published fileprivate(set) var classes: [EditableFacultyGroupClass] = []
    @Published fileprivate(set) var visibleClasses: [EditableFacultyGroupClass] = []
    @Published fileprivate(set) var hiddenClasses: [EditableFacultyGroupClass] = []

    let hideFacultyGroupClass = DriverSubject<EditableFacultyGroupClass>()
    let unhideFacultyGroupClass = DriverSubject<EditableFacultyGroupClass>()

    init(viewType: FacultyGroupDetailsViewType) {
        self.viewType = viewType
    }
}

struct FacultyGroupClassListViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let viewType: FacultyGroupDetailsViewType
    let facultyGroupName: String
    let classes: [EditableFacultyGroupClass]

    func makeStore(context: Context) -> FacultyGroupClassListStore {
        let store = FacultyGroupClassListStore(viewType: viewType)
        store.classes = classes

        let hiddenClasses = context.appData.$allHiddenClasses
            .map { $0.filter { $0.facultyGroupName == facultyGroupName } }

        hiddenClasses
            .assign(to: &store.$hiddenClasses)

        hiddenClasses
            .map { hiddenClasses in classes.filter { !hiddenClasses.contains($0) } }
            .assign(to: &store.$visibleClasses)

        store.hideFacultyGroupClass
            .sink { context.appData.hideFacultyGroupClass($0) }
            .store(in: &store.cancellables)

        store.unhideFacultyGroupClass
            .sink { context.appData.unhideFacultyGroupClass($0) }
            .store(in: &store.cancellables)

        return store
    }
}
