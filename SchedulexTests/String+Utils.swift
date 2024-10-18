//
//  String+Utils.swift
//  SchedulexTests
//
//  Created by Sebastian Staszczyk on 18/10/2024.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            dateFormatter.dateFormat = "dd.MM.yy HH:mm"
            return dateFormatter.date(from: self)!
        }
    }

    func toUUID() -> UUID {
        let hashValue = hashValue
        let uuid = UUID(uuid: (
            UInt8(truncatingIfNeeded: (hashValue >> 24) & 0xFF),
            UInt8(truncatingIfNeeded: (hashValue >> 16) & 0xFF),
            UInt8(truncatingIfNeeded: (hashValue >> 8) & 0xFF),
            UInt8(truncatingIfNeeded: hashValue & 0xFF),
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        ))
        return uuid
    }
}
