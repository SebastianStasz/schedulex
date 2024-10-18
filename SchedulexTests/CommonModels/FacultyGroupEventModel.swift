//
//  FacultyGroupEventModel.swift
//  SchedulexTests
//
//  Created by Sebastian Staszczyk on 18/10/2024.
//

import Domain
import Foundation
@testable import UEK_Schedule

struct FacultyGroupEventModel {
    private let id: String
    private let name: String
    private let date: String
    private let startTime: String
    private let endTime: String

    init(id: String, name: String, date: String, from startTime: String, to endTime: String) {
        self.id = id
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
    }

    func toFacultyGroupEvent() -> FacultyGroupEvent {
        FacultyGroupEvent(facultyGroupName: "", color: .blue, event: event)
    }

    private var event: Event {
        Event(id: id.toUUID(), name: name, startDate: startDate, endDate: endDate, isRemoteClass: false, isEventTransfer: false)
    }

    private var startDate: Date {
        "\(date) \(startTime)".toDate()
    }

    private var endDate: Date {
        "\(date) \(endTime)".toDate()
    }
}
