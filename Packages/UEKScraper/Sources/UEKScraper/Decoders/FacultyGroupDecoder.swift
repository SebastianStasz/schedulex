//
//  FacultyGroupDecoder.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 14/06/2024.
//

import Domain

struct FacultyGroupDecoder {
    private let datesDecoder = DatesDecoder()
    private let decoder: DetailsDecoder

    init(facultyGroup: FacultyGroup) {
        decoder = DetailsDecoder(decodingType: .facultyGroup(facultyGroup))
    }

    func decode(from content: String, facultyGroup: FacultyGroup) throws -> FacultyGroupDetails {
        let eventsData = try decoder.decodeEventsData(from: content)
        let events = eventsData.compactMap { $0.toEvent(datesDecoder: datesDecoder) }
        let classes = getClasses(from: eventsData)
        return FacultyGroupDetails(facultyGroup: facultyGroup, isHidden: facultyGroup.isHidden, events: events, classes: classes)
    }

    private func getClasses(from events: [EventData]) -> [FacultyGroupClass] {
        Array(Set(events.compactMap { $0.toFacultyGroupClass() }))
            .sorted { $0.name == $1.name ? $0.type > $1.type : $0.name < $1.name }
    }
}
