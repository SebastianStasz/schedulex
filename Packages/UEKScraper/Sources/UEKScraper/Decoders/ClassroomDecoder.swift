//
//  ClassroomDecoder.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 14/06/2024.
//

import Domain

struct ClassroomDecoder {
    private let datesDecoder = DatesDecoder()
    private let decoder: DetailsDecoder

    init(classroom: Classroom) {
        decoder = DetailsDecoder(decodingType: .classroom(classroom))
    }

    func decodeEvents(from content: String, classroom: Classroom) throws -> [Event] {
        let eventsData = try decoder.decodeEventsData(from: content)
        let events = eventsData.compactMap { $0.toEvent(datesDecoder: datesDecoder) }
        return events
    }
}
