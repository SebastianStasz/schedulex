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
    private let detailsDecoder = DetailsDecoder()

    public init() {}

    public func getEvents(from urlString: String) async throws -> [Event] {
        let webContent = try await apiService.getWebContent(from: urlString)
        let events = try detailsDecoder.toEvents(from: webContent)
        return events
    }

    public func getFacultyGroupDetails(for facultyGroup: FacultyGroup) async throws -> FacultyGroupDetails {
        let webContent = try await apiService.getWebContent(from: facultyGroup.facultyUrl)
        let details = try detailsDecoder.toFacultyGroupDetails(from: webContent, facultyGroup: facultyGroup)
        return details
    }
}
