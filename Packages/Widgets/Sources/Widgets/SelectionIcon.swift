//
//  SelectionIcon.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 12/10/2023.
//

import SwiftUI

public struct SelectionIcon: View {
    private let isSelected: Bool
    private let color: Color?

    public init(isSelected: Bool, color: Color? = nil) {
        self.isSelected = isSelected
        self.color = color
    }

    public var body: some View {
        Image.icon(icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(iconColor)
    }

    private var icon: Icon {
        isSelected ? .checkmark : .circle
    }

    private var iconColor: Color {
        color ?? selectionColor
    }

    private var selectionColor: Color {
        isSelected ? .greenPrimary : .accentPrimary
    }
}

#Preview {
    VStack(spacing: .xlarge) {
        SelectionIcon(isSelected: true)
        SelectionIcon(isSelected: false)
    }
    .padding(.xlarge)
}
