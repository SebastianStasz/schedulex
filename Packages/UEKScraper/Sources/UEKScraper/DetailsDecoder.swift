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
        let events = rows.compactMap { getEvent(from: $0, facultyGroup: facultyGroup) }
        let classes = getClasses(from: events)
        return FacultyGroupDetails(events: events, classes: classes)
    }

    private func getClasses(from events: [Event]) -> [FacultyGroupClass] {
        let allClasses: [FacultyGroupClass] = events
            .compactMap {
                guard let name = $0.name, let type = $0.type, let teacher = $0.teacher, isValidClass(teacher: teacher, type: type), !name.isEmpty else { return nil }
                return FacultyGroupClass(name: name, type: type, teacher: teacher)
            }
        return Array(Set(allClasses))
            .sorted {
                guard $0.name != $1.name else {
                    return $0.type > $1.type
                }
                return $0.name < $1.name
            }
    }

    private func getEvent(from row: Element, facultyGroup: FacultyGroup) -> Event? {
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
            if shouldOmitEvent(facultyGroup: facultyGroup, name: name, place: place, type: type) {
                return nil
            }
            let dates = datesDecoder.getDates(date: date, time: time)
            return Event(startDate: dates.0, endDate: dates.1, name: name, place: place, teacher: teacher, type: type)
        } catch {
            return nil
        }
    }

    private func isValidClass(teacher: String, type: String) -> Bool {
        teacher != "Studencki Uek Parlament" && type != "rezerwacja"
    }

    private func shouldOmitEvent(facultyGroup: FacultyGroup, name: String, place: String, type: String) -> Bool {
        guard !facultyGroup.name.hasPrefix("CJ") else { return false }
        return name.contains("grupa przedmiotów") || place == "Wybierz swoją grupę językową" || type == "lektorat"
    }
}
