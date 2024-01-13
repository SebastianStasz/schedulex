//
//  OnboardingSecondStepViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Domain
import Foundation
import SchedulexFirebase

final class OnboardingSecondStepStore: RootStore {
    @Published fileprivate(set) var languageGroups: [FacultyGroup] = []
    @Published fileprivate(set) var canConfirmSelection = false

    @Published var selectedLanguageGroups: [FacultyGroup] = []

    let confirmGroupsSelection = DriverSubject<Void>()
}

struct OnboardingSecondStepViewModel: ViewModel {
    let selectedFacultyGroups: [FacultyGroup]
    let onFinishOnboarding: () -> Void

    func makeStore(context: Context) -> OnboardingSecondStepStore {
        let store = OnboardingSecondStepStore()

        store.viewWillAppear
            .perform { try await context.firestoreService.getCracowUniversityOfEconomics() }
            .sinkAndStore(on: store) { $0.languageGroups = $1.languageGroups }

        store.$selectedLanguageGroups
            .map { !$0.isEmpty || !selectedFacultyGroups.isEmpty }
            .assign(to: &store.$canConfirmSelection)

        store.confirmGroupsSelection
            .sinkAndStore(on: store) { store, _ in
                let allGroups = selectedFacultyGroups + store.selectedLanguageGroups
                confirmGroupsSelection(allGroups, context: context)
            }

        return store
    }

    private func confirmGroupsSelection(_ selectedGroups: [FacultyGroup], context: Context) {
        var newGroups: [FacultyGroup] = []
        var availableColors = FacultyGroupColor.allCases

        for group in selectedGroups {
            var group = group
            let color = availableColors.first
            group.color = color ?? .default
            availableColors.removeAll(where: { $0 == color })
            newGroups.append(group)
        }
        context.appData.subscribedFacultyGroups = newGroups
        onFinishOnboarding()
    }
}
