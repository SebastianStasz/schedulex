//
//  UekScheduleService.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/09/2023.
//

import Domain
import Foundation

public struct UekScheduleService {
    private let apiService = APIService()
    private let eventsDecoder = EventsDecoder()

    public init () {}

    public func getFacultyGroupEvents() async throws -> FacultyGroupEvents {
        let url = "https://planzajec.uek.krakow.pl/index.php?typ=G&id=188731&okres=3"
        let events = try await getEvents(from: url)
        return FacultyGroupEvents(events: events)
    }

    private func getEvents(from urlString: String) async throws -> [Event] {
        let webContent = try await apiService.getWebContent(from: urlString)
        let events = try eventsDecoder.decodeEvents(from: webContent)
        return events
    }
}
