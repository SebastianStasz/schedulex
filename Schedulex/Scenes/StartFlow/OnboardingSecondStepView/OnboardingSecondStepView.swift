//
//  OnboardingSecondStepView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Resources
import SwiftUI
import Widgets

struct OnboardingSecondStepView: RootView {
    @ObservedObject var store: OnboardingSecondStepStore

    var rootBody: some View {
        GroupsSelectionListView(groups: store.languageGroups, emptyMessage: L10n.startSecondStepNoLanguages, selectedGroups: $store.selectedLanguageGroups)
            .keyboardButton(L10n.confirmButton, disabled: !store.canConfirmSelection, action: store.confirmGroupsSelection.send)
            .baseListStyle()
    }
}

final class OnboardingSecondStepViewController: SwiftUIViewController<OnboardingSecondStepViewModel, OnboardingSecondStepView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.startSecondStepTitle
    }
}

#Preview {
    OnboardingSecondStepView(store: OnboardingSecondStepStore())
}
