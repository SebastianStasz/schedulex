//
//  CalendarPickerMonth.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 12/11/2023.
//

import Foundation

struct CalendarPickerMonth: Identifiable {
    let yearAndMonth: YearAndMonth
    let dayPickerItems: [DayPickerItem]

    var id: Date {
        yearAndMonth.date
    }

    var daysOffset: Int {
        let weekdayShift = yearAndMonth.date.weekday - 2
        return weekdayShift < 0 ? weekdayShift + 7 : weekdayShift
    }

    func getDays() -> [DayPickerItem] {
        var days: [DayPickerItem] = dayPickerItems

        if let firstDay = days.first?.date.day, firstDay > 1 {
            let nonSelectableDays: [DayPickerItem] = (1..<firstDay).compactMap {
                makeDayPickerItem(for: $0)
            }
            days.insert(contentsOf: nonSelectableDays, at: 0)
        }
        if let lastDay = days.last, lastDay.date.day < yearAndMonth.numberOfDaysInMonth {
            let firstMissingDay = lastDay.date.day + 1
            let nonSelectableDays: [DayPickerItem] = (firstMissingDay..<yearAndMonth.numberOfDaysInMonth).compactMap {
                makeDayPickerItem(for: $0)
            }
            days.append(contentsOf: nonSelectableDays)
        }
        return days
    }

    private func makeDayPickerItem(for day: Int) -> DayPickerItem? {
        let components = DateComponents(year: yearAndMonth.year, month: yearAndMonth.month, day: day)
        guard let date = Calendar.current.date(from: components) else { return nil }
        return DayPickerItem(date: date, isSelectable: false)
    }
}
