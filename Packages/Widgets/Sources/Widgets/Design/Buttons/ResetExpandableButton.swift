//
//  ResetExpandableButton.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 26/09/2024.
//

import Resources
import SwiftUI

public struct ResetExpandableButton: View {
    private let title: String
    private let isDefaultValueSelected: Bool
    private let action: () -> Void

    public init(title: String, isDefaultValueSelected: Bool, action: @escaping () -> Void) {
        self.title = title
        self.isDefaultValueSelected = isDefaultValueSelected
        self.action = action
    }

    public var body: some View {
        Button(title, action: performAction)
            .buttonStyle(.expandableButtonStyle(icon: dateSelectionButtonIcon, isExpanded: !isDefaultValueSelected))
            .disabled(isDefaultValueSelected)
            .animation(.easeInOut(duration: 0.2), value: isDefaultValueSelected)
    }

    private var dateSelectionButtonIcon: Icon {
        isDefaultValueSelected ? .recordCircle : .chevronForwardCircle
    }

    private func performAction() {
        action()
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
}

#Preview {
    VStack {
        ResetExpandableButton(title: "Reset", isDefaultValueSelected: true, action: {})
        ResetExpandableButton(title: "Reset", isDefaultValueSelected: false, action: {})
    }
}
