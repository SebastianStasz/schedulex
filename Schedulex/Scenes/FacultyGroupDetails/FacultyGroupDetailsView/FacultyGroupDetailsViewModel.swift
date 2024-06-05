//
//  FacultyGroupDetailsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import SchedulexCore
import SchedulexViewModel
import SwiftUI
import UEKScraper

final class FacultyGroupDetailsStore: RootStore {
    let isLoading = DriverState(true)
    let viewType: FacultyGroupDetailsViewType

    @Published fileprivate(set) var facultyGroup: FacultyGroup
    @Published fileprivate(set) var isFacultyGroupSubscribed = false
    @Published fileprivate(set) var facultyGroupDetails: FacultyGroupDetails?

    let navigateToEventsList = DriverSubject<Void>()
    let navigateToClassList = DriverSubject<Void>()
    let navigateToColorSelection = DriverSubject<Void>()
    let subscribeFacultyGroup = DriverSubject<Void>()
    let unsubscribeFacultyGroup = DriverSubject<Void>()

    init(facultyGroup: FacultyGroup, viewType: FacultyGroupDetailsViewType) {
        self.facultyGroup = facultyGroup
        self.viewType = viewType
    }
}

struct FacultyGroupDetailsViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let viewType: FacultyGroupDetailsViewType
    let facultyGroup: FacultyGroup

    func makeStore(context: Context) -> FacultyGroupDetailsStore {
        let store = FacultyGroupDetailsStore(facultyGroup: facultyGroup, viewType: viewType)
        let service = UekScheduleService()

        store.viewWillAppear
            .perform(isLoading: store.isLoading) {
                try await service.getFacultyGroupDetails(for: facultyGroup)
            }
            .assign(to: &store.$facultyGroupDetails)

        context.appData.$subscribedFacultyGroups
            .compactMap { $0.first(where: { $0.name == facultyGroup.name }) }
            .assign(to: &store.$facultyGroup)

        context.appData.$subscribedFacultyGroups
            .map { $0.contains(where: { $0.name == facultyGroup.name }) }
            .assign(to: &store.$isFacultyGroupSubscribed)

        store.unsubscribeFacultyGroup
            .sink {
                context.appData.unsubscribeFacultyGroup(facultyGroup)
                dismissOrPop()
            }
            .store(in: &store.cancellables)

        store.subscribeFacultyGroup
            .sink {
                context.appData.subscribeFacultyGroup(facultyGroup)
                dismissOrPop()
            }
            .store(in: &store.cancellables)

        store.navigateToColorSelection
            .sink { navigateToFacultyGroupColorSelection() }
            .store(in: &store.cancellables)

        store.navigateToClassList
            .sink { navigateToFacultyGroupClassList(classes: store.facultyGroupDetails?.classes ?? []) }
            .store(in: &store.cancellables)

        store.navigateToEventsList
            .sinkAndStore(on: store) { store, _ in
                navigateToFacultyGroupEventsListView(events: store.facultyGroupDetails?.events ?? [])
            }

        return store
    }

    private func dismissOrPop() {
        if viewType == .preview {
            navigationController?.dismiss()
        } else {
            navigationController?.pop()
        }
    }

    private func navigateToFacultyGroupColorSelection() {
        let viewModel = FacultyGroupColorPickerViewModel(navigationController: navigationController, facultyGroup: facultyGroup)
        let viewController = FacultyGroupColorPickerViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    private func navigateToFacultyGroupClassList(classes: [FacultyGroupClass]) {
        let editableClasses = classes.map { $0.toEditableFacultyGroupClass(facultyGroupName: facultyGroup.name) }
        let viewModel = FacultyGroupClassListViewModel(navigationController: navigationController, viewType: viewType, facultyGroupName: facultyGroup.name, classes: editableClasses)
        let viewController = FacultyGroupClassListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    private func navigateToFacultyGroupEventsListView(events: [Event]) {
        let view = FacultyGroupEventListView(facultyGroupName: facultyGroup.name, events: events)
        let viewController = UIHostingController(rootView: view)
        viewController.title = facultyGroup.name
        navigationController?.push(viewController)
    }
}
