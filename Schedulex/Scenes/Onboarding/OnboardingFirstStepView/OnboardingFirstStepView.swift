//
//  OnboardingFirstStepView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct OnboardingFirstStepView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: StartFirstStepStore

    var rootBody: some View {
        GroupsSelectionListView(groups: store.facultyGroups, emptyMessage: L10n.startFirstStepNoGroups, bottomInset: 48, isSearchFocused: $isSearchFocused, selectedGroups: $store.selectedFacultyGroups)
            .alert(L10n.startFirstStepAlertTitle, isPresented: $store.isConfirmationAlertPresented) {
                Button(L10n.continueButton, action: store.onConfirmationAlertContinueButton.send)
                Button(L10n.cancelButton, role: .cancel) {}
            } message: {
                Text(L10n.startFirstStepAlertMessage)
            }
            .keyboardButton(L10n.nextButton, isKeyboardVisible: $isSearchFocused, isHidden: store.isLoading.value, action: store.onNextButton.send)
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
