//
//  FacultyGroupDetailsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import UIKit
import UEKScraper

final class FacultyGroupDetailsStore: RootStore {
    let isLoading = DriverState(true)

    @Published fileprivate(set) var facultyGroup: FacultyGroup
    @Published fileprivate(set) var isFacultyGroupSubscribed = false
    @Published fileprivate(set) var facultyGroupDetails: FacultyGroupDetails?

    let navigateToColorSelection = DriverSubject<Void>()
    let subscribeFacultyGroup = DriverSubject<Void>()
    let unsubscribeFacultyGroup = DriverSubject<Void>()

    init(facultyGroup: FacultyGroup) {
        self.facultyGroup = facultyGroup
    }
}

struct FacultyGroupDetailsViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let facultyGroup: FacultyGroup

    func makeStore(context: Context) -> FacultyGroupDetailsStore {
        let store = FacultyGroupDetailsStore(facultyGroup: facultyGroup)
        let service = UekScheduleService()

        store.viewWillAppear
            .perform(isLoading: store.isLoading) {
                try await service.getFacultyGroupDetails(for: facultyGroup)
            }
            .assign(to: &store.$facultyGroupDetails)

        context.$appData
            .compactMap { $0.subscribedFacultyGroups.first(where: { $0.name == facultyGroup.name }) }
            .assign(to: &store.$facultyGroup)

        context.$appData
            .map { $0.subscribedFacultyGroups.contains(facultyGroup) }
            .assign(to: &store.$isFacultyGroupSubscribed)

        store.unsubscribeFacultyGroup
            .sink {
                context.appData.unsubscribeFacultyGroup(facultyGroup)
                navigationController?.pop()
            }
            .store(in: &store.cancellables)

        store.subscribeFacultyGroup
            .sink {
                context.appData.subscribeFacultyGroup(facultyGroup)
                navigationController?.dismiss()
            }
            .store(in: &store.cancellables)

        store.navigateToColorSelection
            .sink { navigateToFacultyGroupColorSelection() }
            .store(in: &store.cancellables)

        return store
    }

    private func navigateToFacultyGroupColorSelection() {
        let viewModel = FacultyGroupColorPickerViewModel(navigationController: navigationController, facultyGroup: facultyGroup)
        let viewController = FacultyGroupColorPickerViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
