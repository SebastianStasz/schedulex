//
//  DayPickerItem.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 31/10/2023.
//

import SwiftUI

public struct DayPickerItem: Hashable, Identifiable {
    public let id = UUID()
    public let date: Date
    let circleColors: [Color]
    let hasFreeHours: Bool
    let isSelectable: Bool

    var isToday: Bool {
        date.isSameDay(as: .now)
    }

    public init(date: Date, circleColors: [Color] = [], hasFreeHours: Bool = false, isSelectable: Bool = true) {
        self.date = date
        self.circleColors = circleColors
        self.hasFreeHours = hasFreeHours
        self.isSelectable = isSelectable
    }
}
