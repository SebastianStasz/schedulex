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
    private let decodingType: DecodingType

    init(decodingType: DecodingType) {
        self.decodingType = decodingType
    }

    func decodeEventsData(from content: String) throws -> [EventData] {
        let document = try SwiftSoup.parse(content)
        let rows = try document.select("table tr").array()
        return eventsData(from: rows)
    }

    private func eventsData(from rows: [Element]) -> [EventData] {
        rows.enumerated().compactMap { index, row in
            guard var eventData = toEventData(from: row) else { return nil }
            if eventData.isEventTransfer, let nextRow = rows[safe: index + 1] {
                eventData.eventTransferNote = eventTransferNote(from: nextRow)
            }
            return eventData
        }
    }

    private func eventTransferNote(from row: Element) -> String? {
        try? row.select("td").array().compactMap { try? $0.text() }.first { !$0.isEmpty }
    }

    private func toEventData(from row: Element) -> EventData? {
        guard let columns = try? row.select("td").array() else { return nil }

        let cells = columns.compactMap { try? $0.text() }
        guard cells.count == 6 else { return nil }

        let teacherProfileLink = try? columns[4].select("a").attr("href")
        let teamsLink = try? columns[5].select("a").attr("href")

        let eventData = EventData(
            name: cells[2].nilIfEmpty(),
            type: cells[3].nilIfEmpty(),
            date: cells[0],
            time: cells[1],
            place: decodingType.getPlace(from: cells[5]),
            teacher: decodingType.getTeacher(from: cells[4]),
            teamsLink: teacherProfileLink,
            facultyGroup: decodingType.getFacultyGroup(from: cells[5]),
            teacherProfileLink: teamsLink,
            eventTransferNote: nil
        )
        let isValidEvent = eventData.isValidEvent(omitLanguageClasses: decodingType.omitLanguageClasses)
        return isValidEvent ? eventData : nil
    }
}
