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

    var body: some View {
        NavigationStack {
            GroupsSelectionListView(groups: viewModel.facultyGroups, selectedGroups: $viewModel.selectedGroups)
                .baseListStyle(isLoading: viewModel.isLoading)
                .navigationTitle(L10n.startFirstStepTitle)
                .toolbar { toolbarContent }
                .navigationDestination(isPresented: $isSecondStepPresented) {
                    StartSecondStepView(viewModel: viewModel)
                }
        }
        .task { try? await viewModel.fetchData() }
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            TextButton(L10n.nextButton, disabled: viewModel.isLoading) {
                isSecondStepPresented = true
            }
        }
    }
}

#Preview {
    StartFirstStepView(viewModel: StartFlowViewModel())
}
