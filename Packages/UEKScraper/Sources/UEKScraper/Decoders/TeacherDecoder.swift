//
//  TeacherDecoder.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 17/06/2024.
//

import Domain

struct TeacherDecoder {
    private let datesDecoder = DatesDecoder()
    private let decoder: DetailsDecoder

    init(teacher: Teacher) {
        decoder = DetailsDecoder(decodingType: .teacher(teacher))
    }

    func decodeEvents(from content: String) throws -> [Event] {
        let eventsData = try decoder.decodeEventsData(from: content)
        let events = eventsData.compactMap { $0.toEvent(datesDecoder: datesDecoder) }
        return events
    }
}
