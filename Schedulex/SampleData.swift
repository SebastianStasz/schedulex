//
//  SampleData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/08/2023.
//

import Domain
import Foundation

extension Faculty {
    static let sample = Faculty(name: "Applied Informatics", type: .faculty, groups: FacultyGroup.samples)
}

extension FacultyGroup {
    static let sample = FacultyGroup(name: "ZIIAS1-1111", facultyDocument: "Applied Informatics", numberOfEvents: 208)

    static var samples: [FacultyGroup] {
        [FacultyGroup(name: "ZIIAS1-1111", facultyDocument: "Applied Informatics", numberOfEvents: 208),
         FacultyGroup(name: "ZIIAS1-1112", facultyDocument: "Applied Informatics", numberOfEvents: 145),
         FacultyGroup(name: "ZIIAS1-1113", facultyDocument: "Applied Informatics", numberOfEvents: 231)]
    }
}

extension Event {
    static let sample = Event(startDate: .now, endDate: .now, name: "Probability and Statistics", place: "Place", teacher: "dr Some Name", type: "Lecture")
}
