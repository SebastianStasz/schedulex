//
//  StartSecondStepView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct StartSecondStepView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @ObservedObject var viewModel: StartFlowViewModel

    var body: some View {
        GroupsSelectionListView(groups: viewModel.languageGroups, emptyMessage: L10n.startSecondStepNoLanguages, selectedGroups: $viewModel.selectedLanguages)
            .keyboardButton(L10n.confirmButton, disabled: !viewModel.canConfirmSelection, action: confirmGroupsSelection)
            .navigationTitle(L10n.startSecondStepTitle)
            .navigationBarTitleDisplayMode(.inline)
            .baseListStyle()
    }

    private func confirmGroupsSelection() {
        subscribedGroups = viewModel.allSelectedGroups
    }
}

#Preview {
    StartSecondStepView(viewModel: StartFlowViewModel())
}
