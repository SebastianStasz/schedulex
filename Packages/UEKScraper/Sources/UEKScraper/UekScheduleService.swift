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

    public func getFacultyGroupEvents(for facultyGroup: FacultyGroup) async throws -> FacultyGroupEvents {
        let events = try await getEvents(from: facultyGroup.facultyUrl)
        return FacultyGroupEvents(events: events)
    }

    private func getEvents(from urlString: String) async throws -> [Event] {
        let webContent = try await apiService.getWebContent(from: urlString)
        let events = try eventsDecoder.decodeEvents(from: webContent)
        return events
    }
}
