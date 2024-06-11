//
//  DetailsDecoder.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/09/2023.
//

import Domain
import Foundation
import SwiftSoup

struct DetailsDecoder {
    typealias EventDataValidator = (EventData) -> Bool
    private let datesDecoder = DatesDecoder()

    func toFacultyGroupDetails(from content: String, facultyGroup: FacultyGroup) throws -> FacultyGroupDetails {
        let eventsData = try decodeEventsData(from: content, omitLanguageClasses: !facultyGroup.isLanguage)
        let events = eventsData.compactMap { $0.toEvent(datesDecoder: datesDecoder) }
        let classes = getClasses(from: eventsData)
        return FacultyGroupDetails(facultyGroup: facultyGroup, isHidden: facultyGroup.isHidden, events: events, classes: classes)
    }

    func toEvents(from content: String) throws -> [Event] {
        let eventsData = try decodeEventsData(from: content, omitLanguageClasses: false)
        let events = eventsData.compactMap { $0.toEvent(datesDecoder: datesDecoder) }
        return events
    }

    private func decodeEventsData(from content: String, omitLanguageClasses: Bool) throws -> [EventData] {
        let document = try SwiftSoup.parse(content)
        let table = try document.select("table")
        let rows = try table.select("tr").array()
        let eventsData = eventsData(from: rows, omitLanguageClasses: omitLanguageClasses)
        return eventsData
    }

    private func eventsData(from rows: [Element], omitLanguageClasses: Bool) -> [EventData] {
        var events: [EventData] = []
        for (index, row) in rows.enumerated() {
            if var eventData = toEventData(from: row, omitLanguageClasses: omitLanguageClasses) {
                if eventData.isEventTransfer, let row = rows[safe: index + 1] {
                    let eventTransferNote = eventTransferNote(from: row)
                    eventData.eventTransferNote = eventTransferNote
                }
                events.append(eventData)
            }
        }
        return events
    }

    private func eventTransferNote(from row: Element) -> String? {
        guard let notes = try? row.select("td").array().compactMap({ try? $0.text() }), notes.count == 1 else { return nil }
        return notes.first
    }

    private func toEventData(from row: Element, omitLanguageClasses: Bool) -> EventData? {
        guard let columns = try? row.select("td").array() else { return nil }

        let cells = columns.compactMap { try? $0.text() }
        guard cells.count == 6 else { return nil }

        let teacherProfileLink = try? columns[4].select("a").attr("href")
        let teamsLink = try? columns[5].select("a").attr("href")

        let eventData = EventData(name: cells[2].nilIfEmpty(),
                                  type: cells[3].nilIfEmpty(),
                                  date: cells[0],
                                  time: cells[1],
                                  place: cells[5].nilIfEmpty(),
                                  teacher: cells[4].nilIfEmpty(),
                                  teacherProfileLink: teacherProfileLink,
                                  teamsLink: teamsLink,
                                  eventTransferNote: nil)
        let isValidEvent = eventData.isValidEvent(omitLanguageClasses: omitLanguageClasses)
        return isValidEvent ? eventData : nil
    }

    private func getClasses(from events: [EventData]) -> [FacultyGroupClass] {
        let allClasses = events.compactMap { $0.toFacultyGroupClass() }
        return Array(Set(allClasses))
            .sorted {
                guard $0.name != $1.name else {
                    return $0.type > $1.type
                }
                return $0.name < $1.name
            }
    }
}
