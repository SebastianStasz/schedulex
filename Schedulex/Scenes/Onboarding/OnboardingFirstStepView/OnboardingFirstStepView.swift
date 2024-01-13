//
//  OnboardingFirstStepView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Resources
import SwiftUI
import Widgets

struct OnboardingFirstStepView: RootView {
    @ObservedObject var store: StartFirstStepStore

    var rootBody: some View {
        GroupsSelectionListView(groups: store.facultyGroups, emptyMessage: L10n.startFirstStepNoGroups, selectedGroups: $store.selectedFacultyGroups)
            .keyboardButton(L10n.nextButton, disabled: store.isLoading, action: store.onNextButton.send)
            .alert(L10n.startFirstStepAlertTitle, isPresented: $store.isConfirmationAlertPresented) {
                Button(L10n.continueButton, action: store.onConfirmationAlertContinueButton.send)
                Button(L10n.cancelButton, role: .cancel) {}
            } message: {
                Text(L10n.startFirstStepAlertMessage)
            }
    }
}

final class OnboardingFirstStepViewController: SwiftUIViewController<OnboardingFirstStepViewModel, OnboardingFirstStepView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.startFirstStepTitle
    }
}

#Preview {
    OnboardingFirstStepView(store: StartFirstStepStore())
}
