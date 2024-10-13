//
//  OnboardingFirstStepViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Domain
import SchedulexCore
import SchedulexFirebase
import SchedulexViewModel
import UIKit

final class StartFirstStepStore: RootStore {
    @Published fileprivate(set) var facultyGroups: [FacultyGroup] = []

    @Published var isConfirmationAlertPresented = false
    @Published var selectedFacultyGroups: [FacultyGroup] = []

    let isLoading = DriverState(true)

    var onNextButton = DriverSubject<Void>()
    var onConfirmationAlertContinueButton = DriverSubject<Void>()
}

struct OnboardingFirstStepViewModel: ViewModel {
    weak var navigationController: UINavigationController?
    let onFinishOnboarding: () -> Void

    func makeStore(context: Context) -> StartFirstStepStore {
        let store = StartFirstStepStore()
        let presentStartSecondStepView = DriverSubject<Void>()

        store.viewWillAppear
            .perform(isLoading: store.isLoading) { try await context.storage.getCracowUniversityOfEconomicsData() }
            .sink(on: store) { $0.facultyGroups = $1.allGroupsWithoutLanguages }

        store.onNextButton
            .sink(on: store) { store in
                if store.selectedFacultyGroups.isEmpty {
                    store.isConfirmationAlertPresented = true
                } else {
                    presentStartSecondStepView.send()
                }
            }

        store.onConfirmationAlertContinueButton
            .sink(on: store) { _ in presentStartSecondStepView.send() }

        presentStartSecondStepView
            .sink(on: store) { store in
                let viewModel = OnboardingSecondStepViewModel(selectedFacultyGroups: store.selectedFacultyGroups, onFinishOnboarding: onFinishOnboarding)
                let viewController = OnboardingSecondStepViewController(viewModel: viewModel)
                navigationController?.pushViewController(viewController, animated: true)
            }

        return store
    }
}
