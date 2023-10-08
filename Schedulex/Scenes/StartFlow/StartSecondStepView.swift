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
        GroupsSelectionListView(groups: viewModel.languageGroups, selectedGroups: $viewModel.selectedLanguages)
            .navigationTitle(L10n.startSecondStepTitle)
            .toolbar { toolbarContent }
            .baseListStyle()
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            TextButton(L10n.confirmButton, disabled: !viewModel.canConfirmSelection, action: confirmGroupsSelection)
        }
    }

    private func confirmGroupsSelection() {
        subscribedGroups = viewModel.allSelectedGroups
    }
}

#Preview {
    StartSecondStepView(viewModel: StartFlowViewModel())
}
