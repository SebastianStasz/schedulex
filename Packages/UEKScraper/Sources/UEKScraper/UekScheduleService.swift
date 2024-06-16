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

    public init() {}

    public func getEvents(for classroom: Classroom) async throws -> [Event] {
        let decoder = ClassroomDecoder(classroom: classroom)
        let webContent = try await apiService.getWebContent(from: classroom.classroomUrl)
        let events = try decoder.decodeEvents(from: webContent, classroom: classroom)
        return events
    }

    public func getFacultyGroupDetails(for facultyGroup: FacultyGroup) async throws -> FacultyGroupDetails {
        let decoder = FacultyGroupDecoder(facultyGroup: facultyGroup)
        let webContent = try await apiService.getWebContent(from: facultyGroup.facultyUrl)
        let details = try decoder.decode(from: webContent, facultyGroup: facultyGroup)
        return details
    }
}
