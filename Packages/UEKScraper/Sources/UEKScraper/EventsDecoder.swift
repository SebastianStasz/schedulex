//
//  EventsDecoder.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/09/2023.
//

import Domain
import Foundation
import SwiftSoup

struct EventsDecoder {
    private let datesDecoder = DatesDecoder()

    func decodeEvents(from content: String) throws -> [Event] {
        let document = try SwiftSoup.parse(content)
        let table = try document.select("table")
        let rows = try table.select("tr").array()
        return rows.compactMap { getEvent(from: $0) }
    }

    func getEvent(from row: Element) -> Event? {
        do {
            let columns = try row.select("td").array()
            guard columns.count == 6 else { return nil }
            let columnsData = try columns.map { try $0.text() }
            let date = columnsData[0]
            let time = columnsData[1]
            let name = columnsData[2]
            let type = columnsData[3]
            let teacher = columnsData[4]
            let place = columnsData[5]
            let dates = datesDecoder.getDates(date: date, time: time)
            return Event(startDate: dates.0, endDate: dates.1, name: name, place: place, teacher: teacher, type: type)
        } catch {
            return nil
        }
    }
}
