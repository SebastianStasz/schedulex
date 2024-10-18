//
//  ScheduleDataProviderTests.swift
//  SchedulexTests
//
//  Created by Sebastian Staszczyk on 15/10/2024.
//

import XCTest
@testable import UEK_Schedule

final class ScheduleDataProviderTests: TestCase {
    func test_the_one_where_there_is_no_events() throws {
        try checkScheduleDataProvider(expectedEntries: [])
    }

    func test_the_one_where_there_is_one_event_in_the_same_day() throws {
        let facultyGroupEventModel = FacultyGroupEventModel(id: "1", name: "Ekonomia", date: "15.10.2024", from: "13:15", to: "15:00")

        setCurrentDate(to: "15.10.2024 10:00")
        setFacultyGroupEventsByDate(["15.10.2024": [facultyGroupEventModel]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [facultyGroupEventModel]),
            ScheduleEventsEntryModel(date: "15.10.2024 15:00", events: [])
        ])
    }

    func test_the_one_where_there_is_one_event_on_the_next_day() throws {
        let facultyGroupEventModel = FacultyGroupEventModel(id: "1", name: "Ekonomia", date: "16.10.2024 ", from: "13:15", to: "15:00")

        setCurrentDate(to: "15.10.2024 10:00")
        setFacultyGroupEventsByDate(["16.10.2024": [facultyGroupEventModel]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [], NextDayScheduleModel(date: "16.10.2024", events: [facultyGroupEventModel])),
            ScheduleEventsEntryModel(date: "16.10.2024", events: [facultyGroupEventModel]),
            ScheduleEventsEntryModel(date: "16.10.2024 15:00", events: [])
        ])
    }

    func test_the_one_where_there_is_one_event_in_four_days() throws {
        let facultyGroupEventModel = FacultyGroupEventModel(id: "1", name: "Ekonomia", date: "19.10.2024", from: "13:15", to: "15:00")

        setCurrentDate(to: "15.10.2024 10:00")
        setFacultyGroupEventsByDate(["19.10.2024": [facultyGroupEventModel]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [], NextDayScheduleModel(date: "19.10.2024", events: [facultyGroupEventModel])),
            ScheduleEventsEntryModel(date: "19.10.2024", events: [facultyGroupEventModel]),
            ScheduleEventsEntryModel(date: "19.10.2024 15:00", events: [])
        ])
    }

    func test_the_one_where_there_is_one_event_on_the_same_day_but_it_ended() throws {
        let facultyGroupEventModel = FacultyGroupEventModel(id: "1", name: "Ekonomia", date: "15.10.2024", from: "13:15", to: "15:00")

        setCurrentDate(to: "15.10.2024 15:01")
        setFacultyGroupEventsByDate(["15.10.2024": [facultyGroupEventModel]])

        try checkScheduleDataProvider(expectedEntries: [])
    }

    func test_the_one_where_there_is_one_event_on_the_same_day_but_it_ended_and_next_event_is_in_four_days() throws {
        let firstDayEvent = FacultyGroupEventModel(id: "1", name: "Ekonomia", date: "15.10.2024", from: "13:15", to: "15:00")
        let secondDayEvent = FacultyGroupEventModel(id: "2", name: "Matematyka", date: "19.10.2024", from: "15:00", to: "16:30")

        setCurrentDate(to: "15.10.2024 15:01")
        setFacultyGroupEventsByDate(["15.10.2024": [firstDayEvent], "19.10.2024": [secondDayEvent]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [], NextDayScheduleModel(date: "19.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "19.10.2024", events: [secondDayEvent]),
            ScheduleEventsEntryModel(date: "19.10.2024 16:30", events: [])
        ])
    }

    func test_the_one_where_there_are_two_events_on_the_same_day_but_one_ended_and_next_event_is_in_three_days() throws {
        let firstDayEventEnded = FacultyGroupEventModel(id: "1", name: "Marketing", date: "15.10.2024", from: "13:15", to: "15:00")
        let firstDayEventNext = FacultyGroupEventModel(id: "2", name: "Ekonomia", date: "15.10.2024", from: "16:45", to: "18:15")
        let secondDayEvent = FacultyGroupEventModel(id: "3", name: "Matematyka", date: "18.10.2024", from: "15:00", to: "16:30")

        setCurrentDate(to: "15.10.2024 15:01")
        setFacultyGroupEventsByDate(["15.10.2024": [firstDayEventEnded, firstDayEventNext], "18.10.2024": [secondDayEvent]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [firstDayEventNext], NextDayScheduleModel(date: "18.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "15.10.2024 18:15", events: [], NextDayScheduleModel(date: "18.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "18.10.2024", events: [secondDayEvent]),
            ScheduleEventsEntryModel(date: "18.10.2024 16:30", events: [])
        ])
    }

    func test_the_one_where_there_are_two_events_on_the_same_day_and_one_is_in_progress() throws {
        let firstDayEvent = FacultyGroupEventModel(id: "1", name: "Marketing", date: "15.10.2024", from: "13:15", to: "15:00")
        let firstDayEventNext = FacultyGroupEventModel(id: "2", name: "Ekonomia", date: "15.10.2024", from: "16:45", to: "18:15")
        let secondDayEvent = FacultyGroupEventModel(id: "3", name: "Matematyka", date: "18.10.2024", from: "15:00", to: "16:30")

        setCurrentDate(to: "15.10.2024 14:59")
        setFacultyGroupEventsByDate(["15.10.2024": [firstDayEvent, firstDayEventNext], "18.10.2024": [secondDayEvent]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [firstDayEvent, firstDayEventNext], NextDayScheduleModel(date: "18.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "15.10.2024 15:00", events: [firstDayEventNext], NextDayScheduleModel(date: "18.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "15.10.2024 18:15", events: [], NextDayScheduleModel(date: "18.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "18.10.2024", events: [secondDayEvent]),
            ScheduleEventsEntryModel(date: "18.10.2024 16:30", events: [])
        ])
    }

    func test_the_one_where_there_are_two_days_in_a_row_with_events() throws {
        let firstDayEvent = FacultyGroupEventModel(id: "1", name: "Ekonomia", date: "16.10.2024", from: "13:15", to: "14:45")
        let secondDayEvent = FacultyGroupEventModel(id: "2", name: "Matematyka", date: "17.10.2024", from: "15:00", to: "16:30")

        setCurrentDate(to: "15.10.2024 10:00")
        setFacultyGroupEventsByDate(["16.10.2024": [firstDayEvent], "17.10.2024": [secondDayEvent]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [], NextDayScheduleModel(date: "16.10.2024", events: [firstDayEvent])),
            ScheduleEventsEntryModel(date: "16.10.2024", events: [firstDayEvent], NextDayScheduleModel(date: "17.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "16.10.2024 14:45", events: [], NextDayScheduleModel(date: "17.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "17.10.2024", events: [secondDayEvent]),
            ScheduleEventsEntryModel(date: "17.10.2024 16:30", events: [])
        ])
    }

    func test_the_one_where_there_are_two_events_with_the_same_date_and_time() throws {
        let firstDayEvent1 = FacultyGroupEventModel(id: "1", name: "Marketing", date: "15.10.2024", from: "13:15", to: "15:00")
        let firstDayEvent2 = FacultyGroupEventModel(id: "2", name: "Ekonomia", date: "15.10.2024", from: "13:15", to: "15:00")
        let secondDayEvent = FacultyGroupEventModel(id: "3", name: "Matematyka", date: "16.10.2024", from: "15:00", to: "16:30")

        setCurrentDate(to: "15.10.2024 10:00")
        setFacultyGroupEventsByDate(["15.10.2024": [firstDayEvent1, firstDayEvent2], "16.10.2024": [secondDayEvent]])

        try checkScheduleDataProvider(expectedEntries: [
            ScheduleEventsEntryModel(date: "15.10.2024", events: [firstDayEvent1, firstDayEvent2], NextDayScheduleModel(date: "16.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "15.10.2024 15:00", events: [], NextDayScheduleModel(date: "16.10.2024", events: [secondDayEvent])),
            ScheduleEventsEntryModel(date: "16.10.2024", events: [secondDayEvent]),
            ScheduleEventsEntryModel(date: "16.10.2024 16:30", events: [])
        ])
    }

    private func checkScheduleDataProvider(expectedEntries: [ScheduleEventsEntryModel]) throws {
        let provider = ScheduleDataProvider(appGroupData: appGroupData)
        let entries = provider.getScheduleEventEntries()
        XCTAssertEqual(entries, expectedEntries.map { $0.toScheduleEventsEntry() })
    }
}
