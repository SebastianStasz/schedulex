//
//  StartFirstStepViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Domain
import UIKit
import SchedulexFirebase

final class StartFirstStepStore: RootStore {
    @Published fileprivate(set) var isLoading = false
    @Published fileprivate(set) var facultyGroups: [FacultyGroup] = []
    
    @Published var isConfirmationAlertPresented = false
    @Published var selectedFacultyGroups: [FacultyGroup] = []

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
            .perform { try await context.firestoreService.getCracowUniversityOfEconomics() }
            .sinkAndStore(on: store) { $0.facultyGroups = $1.allGroupsWithoutLanguages }

        store.onNextButton
            .sinkAndStore(on: store) { store, _ in
                if store.selectedFacultyGroups.isEmpty {
                    store.isConfirmationAlertPresented = true
                } else {
                    presentStartSecondStepView.send()
                }
            }

        store.onConfirmationAlertContinueButton
            .sink { _ in presentStartSecondStepView.send() }
            .store(in: &store.cancellables)

        presentStartSecondStepView
            .sinkAndStore(on: store) { store, _ in
                let viewModel = OnboardingSecondStepViewModel(selectedFacultyGroups: store.selectedFacultyGroups, onFinishOnboarding: onFinishOnboarding)
                let viewController = OnboardingSecondStepViewController(viewModel: viewModel)
                navigationController?.pushViewController(viewController, animated: true)
            }

        return store
    }
}
