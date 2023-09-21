//
//  DateStyle.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import Foundation

public enum DateStyle {
    case dateLong

    func formatDate(_ date: Date) -> String {
        switch self {
        case .dateLong:
            return date.formatted(date: .long, time: .omitted)
        }
    }
}

public extension Date {
    func formatted(style: DateStyle) -> String {
        style.formatDate(self)
    }
}
