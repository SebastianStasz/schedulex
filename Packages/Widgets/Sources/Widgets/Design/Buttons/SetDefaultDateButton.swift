//
//  SetDefaultDateButton.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 26/09/2024.
//

import Resources
import SwiftUI

public struct SetDefaultDateButton: View {
    private let isDefaultDateSelected: Bool
    private let action: () -> Void

    public init(isDefaultDateSelected: Bool, action: @escaping () -> Void) {
        self.isDefaultDateSelected = isDefaultDateSelected
        self.action = action
    }

    public var body: some View {
        Button(L10n.today, action: action)
            .buttonStyle(.expandableButtonStyle(icon: dateSelectionButtonIcon, isExpanded: !isDefaultDateSelected))
            .disabled(isDefaultDateSelected)
            .animation(.easeInOut(duration: 0.2), value: isDefaultDateSelected)
    }

    private var dateSelectionButtonIcon: Icon {
        isDefaultDateSelected ? .recordCircle : .chevronForwardCircle
    }
}

#Preview {
    VStack {
        SetDefaultDateButton(isDefaultDateSelected: true, action: {})
        SetDefaultDateButton(isDefaultDateSelected: false, action: {})
    }
}
