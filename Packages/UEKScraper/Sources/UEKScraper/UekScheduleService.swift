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

    public init () {}

    public func getFacultyGroupDetails(for facultyGroup: FacultyGroup) async throws -> FacultyGroupDetails {
         try await getDetails(from: facultyGroup.facultyUrl)
    }

    private func getDetails(from urlString: String) async throws -> FacultyGroupDetails {
        let webContent = try await apiService.getWebContent(from: urlString)
        let details = try detailsDecoder.decodeDetails(from: webContent)
        return details
    }
}
