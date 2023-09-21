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
}

public extension Shape {
    func fill(_ colorStyle: ColorStyle) -> some View {
        fill(colorStyle.color)
    }
}
