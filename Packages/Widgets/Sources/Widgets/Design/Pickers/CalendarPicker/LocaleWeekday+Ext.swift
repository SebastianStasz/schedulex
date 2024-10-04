//
//  LocaleWeekday+Ext.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 12/11/2023.
//

import Foundation

extension Locale.Weekday: Identifiable, CaseIterable {
    public var id: String {
        rawValue
    }

    public static var allCases: [Locale.Weekday] {
        [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
}
