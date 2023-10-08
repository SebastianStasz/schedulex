//
//  StartFirstStepView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Resources
import SwiftUI
import Widgets

struct StartFirstStepView: View {
    @StateObject var viewModel: StartFlowViewModel
    @State private var isSecondStepPresented = false
    @State private var isConfirmationAlertPresented = false

    var body: some View {
        NavigationStack {
            GroupsSelectionListView(groups: viewModel.facultyGroups, selectedGroups: $viewModel.selectedGroups)
                .baseListStyle(isLoading: viewModel.isLoading)
                .navigationTitle(L10n.startFirstStepTitle)
                .navigationBarTitleDisplayMode(.inline)
                .keyboardButton(L10n.nextButton, disabled: viewModel.isLoading, action: proceedToSecondStep)
                .navigationDestination(isPresented: $isSecondStepPresented) {
                    StartSecondStepView(viewModel: viewModel)
                }
                .alert(L10n.startFirstStepAlertTitle, isPresented: $isConfirmationAlertPresented) {
                    Button(L10n.continueButton) { isSecondStepPresented = true }
                    Button(L10n.cancelButton, role: .cancel) {}
                } message: {
                    Text(L10n.startFirstStepAlertMessage)
                }
        }
        .task { try? await viewModel.fetchData() }
    }

    private func proceedToSecondStep() {
        if viewModel.selectedGroups.isEmpty {
            isConfirmationAlertPresented = true
        } else {
            isSecondStepPresented = true
        }
    }
}

#Preview {
    StartFirstStepView(viewModel: StartFlowViewModel())
}
