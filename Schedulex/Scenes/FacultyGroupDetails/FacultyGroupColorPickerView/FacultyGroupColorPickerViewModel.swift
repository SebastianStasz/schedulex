//
//  FacultyGroupColorPickerViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import UIKit

final class FacultyGroupColorPickerStore: RootStore {
    let facultyGroup: FacultyGroup

    let setFacultyGroupColor = DriverSubject<FacultyGroupColor>()

    init(facultyGroup: FacultyGroup) {
        self.facultyGroup = facultyGroup
    }
}

struct FacultyGroupColorPickerViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let facultyGroup: FacultyGroup

    func makeStore(context: Context) -> FacultyGroupColorPickerStore {
        let store = FacultyGroupColorPickerStore(facultyGroup: facultyGroup)

        store.setFacultyGroupColor
            .sink(on: store) {
                context.appData.setFacultyGroupColor(for: facultyGroup, color: $0)
                navigationController?.pop()
            }

        return store
    }
}
