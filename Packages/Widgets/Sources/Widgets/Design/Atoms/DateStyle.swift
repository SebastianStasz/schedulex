//
//  DateStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import Foundation

public enum DateStyle {
    case dateLong
    case timeOnly

    func formatDate(_ date: Date) -> String {
        switch self {
        case .dateLong:
            return date.formatted(date: .long, time: .omitted)
        case .timeOnly:
            return date.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)).minute(.twoDigits))
        }
    }
}

public extension Date {
    func formatted(style: DateStyle) -> String {
        style.formatDate(self)
    }
}
