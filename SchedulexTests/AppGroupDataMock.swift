//
//  AppGroupDataMock.swift
//  SchedulexTests
//
//  Created by Sebastian Staszczyk on 15/10/2024.
//

import Domain
import Foundation
@testable import UEK_Schedule

final class AppGroupDataMock: AppGroupDataProvider {
    var facultyGroupEventsByDate: [String: [FacultyGroupEventModel]] = [:]

    func getFacultyGroupEventsByDate() -> FacultyGroupEventsByDay {
        mapModelsToFacultyGroupEventsByDate()
    }

    private func mapModelsToFacultyGroupEventsByDate() -> FacultyGroupEventsByDay {
        facultyGroupEventsByDate.reduce(into: FacultyGroupEventsByDay()) { (partialResult, arg1) in
            let (key, value) = arg1
            let day = Calendar.current.startOfDay(for: key.toDate())
            partialResult[day] = value.map { $0.toFacultyGroupEvent() }
        }
    }
}
