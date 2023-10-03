//
//  View+Ext.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import SwiftUI

public extension View {
    func foregroundStyle(_ colorStyle: ColorStyle) -> some View {
        foregroundStyle(colorStyle.color)
    }

    func background(_ colorStyle: ColorStyle) -> some View {
        background(colorStyle.color)
    }

    /// Displays the view if the condition is true.
    /// - Parameter condition: The condition that must be met in order to display the view.
    /// - Returns: A view if the condition is true.
    @ViewBuilder
    func displayIf(_ condition: Bool) -> some View {
        if condition { self }
    }
}

public extension Shape {
    func fill(_ colorStyle: ColorStyle) -> some View {
        fill(colorStyle.color)
    }
}
