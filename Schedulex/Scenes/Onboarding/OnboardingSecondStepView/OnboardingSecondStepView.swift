//
//  OnboardingSecondStepView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Resources
import SwiftUI
import Widgets
import SchedulexViewModel

struct OnboardingSecondStepView: RootView {
    @State private var isSearchFocused = false
    @ObservedObject var store: OnboardingSecondStepStore

    var rootBody: some View {
        GroupsSelectionListView(groups: store.languageGroups, emptyMessage: L10n.startSecondStepNoLanguages, isSearchFocused: $isSearchFocused, selectedGroups: $store.selectedLanguageGroups)
            .keyboardButton(L10n.confirmButton, isKeyboardVisible: $isSearchFocused, disabled: !store.canConfirmSelection, action: store.confirmGroupsSelection.send)
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
