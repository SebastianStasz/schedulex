//
//  SampleData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/08/2023.
//

import Domain
import Foundation

extension Faculty {
    static let sample = Faculty(name: "Applied Informatics", groups: FacultyGroup.samples)
}

extension FacultyGroup {
    static var samples: [FacultyGroup] {
        [FacultyGroup(name: "ZIIAS1-1111", numberOfEvents: 208),
         FacultyGroup(name: "ZIIAS1-1112", numberOfEvents: 145),
         FacultyGroup(name: "ZIIAS1-1113", numberOfEvents: 231)]
    }
}
