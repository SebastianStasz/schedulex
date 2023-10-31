//
//  DayPickerItem.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 31/10/2023.
//

import SwiftUI

public struct DayPickerItem: Hashable {
    let date: Date
    let circleColors: [Color]

    public init(date: Date, circleColors: [Color] = []) {
        self.date = date
        self.circleColors = circleColors
    }
}
