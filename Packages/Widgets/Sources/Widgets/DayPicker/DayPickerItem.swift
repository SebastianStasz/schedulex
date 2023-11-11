//
//  DayPickerItem.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 31/10/2023.
//

import SwiftUI

public struct DayPickerItem: Hashable, Identifiable {
    public let id = UUID()
    let date: Date
    let circleColors: [Color]
    let isSelectable: Bool
    let isVisible: Bool

    public init(date: Date, circleColors: [Color] = [], isSelectable: Bool = true, isVisible: Bool = true) {
        self.date = date
        self.circleColors = circleColors
        self.isSelectable = isSelectable
        self.isVisible = isVisible
    }
}
