//
//  Weekday.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 09/03/2024.
//

import Foundation
import Resources

enum Weekday: CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturady
    case sunday

    var shortSymbol: String {
        switch self {
        case .monday:
            return L10n.weekdayMondayShort
        case .tuesday:
            return L10n.weekdayTuesdayShort
        case .wednesday:
            return L10n.weekdayWednesdayShort
        case .thursday:
            return L10n.weekdayThursdayShort
        case .friday:
            return L10n.weekdayFridayShort
        case .saturady:
            return L10n.weekdaySaturdayShort
        case .sunday:
            return L10n.weekdaySundayShort
        }
    }
}
