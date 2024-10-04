//
//  ColorPickerSquare.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 16/10/2023.
//

import SwiftUI

public struct ColorPickerSquare: View {
    private let color: Color
    private let cornerRadius: CornerRadius

    public init(color: Color, cornerRadius: CornerRadius) {
        self.color = color
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius.value)
            .fill(color)
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ColorPickerSquare(color: .green, cornerRadius: .medium)
}
