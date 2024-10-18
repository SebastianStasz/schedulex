//
//  DateUtils.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/10/2024.
//

import Foundation

final class DateUtils {
    static var dateProvider = { Date.now }
    static var date: Date { dateProvider() }
}
