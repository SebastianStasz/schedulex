//
//  Date+Ext.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import Foundation

public extension Date {
    func isSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}
