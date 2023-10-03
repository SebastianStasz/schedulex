//
//  Date+Ext.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import Foundation

public extension Date {
    func isSameDay(as date: Date) -> Bool {
        formatted(date: .numeric, time: .omitted) == date.formatted(date: .numeric, time: .omitted)
    }
}
