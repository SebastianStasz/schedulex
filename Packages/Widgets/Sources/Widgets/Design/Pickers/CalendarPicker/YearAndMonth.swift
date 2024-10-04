//
//  YearAndMonth.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 12/11/2023.
//

import Foundation

struct YearAndMonth: Hashable {
    let year: Int
    let month: Int

    var date: Date {
        let components = DateComponents(year: year, month: month)
        return Calendar.current.date(from: components)!
    }

    var numberOfDaysInMonth: Int {
        Calendar.current.range(of: .day, in: .month, for: date)!.count
    }
}

extension Date {
    func toYearAndMonth() -> YearAndMonth {
        YearAndMonth(year: year, month: month)
    }
}
