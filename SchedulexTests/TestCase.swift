//
//  TestCase.swift
//  SchedulexTests
//
//  Created by Sebastian Staszczyk on 18/10/2024.
//

import Foundation
import XCTest
@testable import UEK_Schedule

class TestCase: XCTestCase {
    let appGroupData = AppGroupDataMock()
}

extension TestCase {
    func setFacultyGroupEventsByDate(_ models: [String: [FacultyGroupEventModel]]) {
        appGroupData.facultyGroupEventsByDate = models
    }
    
    func setCurrentDate(to date: String) {
        DateUtils.dateProvider = { date.toDate() }
    }
}
