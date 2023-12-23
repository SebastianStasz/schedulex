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
    private let datesDecoder = DatesDecoder()

    func decodeDetails(from content: String, facultyGroup: FacultyGroup) throws -> FacultyGroupDetails {
        let document = try SwiftSoup.parse(content)
        let table = try document.select("table")
        let rows = try table.select("tr").array()
        let eventsData = eventsData(from: rows, for: facultyGroup)
        let events = eventsData.map { $0.toEvent(facultyGroup: facultyGroup, datesDecoder: datesDecoder) }
        let classes = getClasses(from: eventsData)
        return FacultyGroupDetails(events: events, classes: classes)
    }

    private func eventsData(from rows: [Element], for facultyGroup: FacultyGroup) -> [EventData] {
        var events: [EventData] = []
        for (index, row) in rows.enumerated() {
            if var eventData = toEventData(from: row, for: facultyGroup) {
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

    private func toEventData(from row: Element, for facultyGroup: FacultyGroup) -> EventData? {
        guard let columns = try? row.select("td").array().compactMap({ try? $0.text() }), columns.count == 6 else { return nil }
        let eventData = EventData(name: columns[2].nilIfEmpty(),
                                  type: columns[3].nilIfEmpty(),
                                  date: columns[0], 
                                  time: columns[1],
                                  place: columns[5].nilIfEmpty(), 
                                  teacher: columns[4].nilIfEmpty(), 
                                  eventTransferNote: nil)
        return eventData.isValidEvent(for: facultyGroup) ? eventData : nil
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
