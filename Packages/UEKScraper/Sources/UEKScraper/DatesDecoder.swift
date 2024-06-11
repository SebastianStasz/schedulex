//
//  DatesDecoder.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/09/2023.
//

import Foundation

struct DatesDecoder {
    private let formatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        return formatter
    }()

    func getDates(date: String, time: String) -> (Date, Date)? {
        guard let startDate = getDate(date: date, time: time, hourRange: 3 ..< 5, minutesRange: 6 ..< 8),
              let endDate = getDate(date: date, time: time, hourRange: 11 ..< 13, minutesRange: 14 ..< 16)
        else { return nil }
        return (startDate, endDate)
    }

    private func getDate(date: String, time: String, hourRange: Range<Int>, minutesRange: Range<Int>) -> Date? {
        guard let hour = Int(time[hourRange]),
              let minutes = Int(time[minutesRange]),
              let date = formatter.date(from: date)
        else { return nil }
        let startDate = Calendar.current.date(bySettingHour: hour, minute: minutes, second: 0, of: date)
        return startDate!
    }
}

private extension String {
    subscript(bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
}
