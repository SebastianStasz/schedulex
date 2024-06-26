//
//  FacultyGroupEvent.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 11/06/2024.
//

import Domain
import Foundation

struct FacultyGroupEvent: Hashable, Identifiable {
    let facultyGroupName: String
    let color: FacultyGroupColor
    let event: Event

    var startDate: Date? { event.startDate }
    var endDate: Date? { event.endDate }

    var id: UUID { event.id }
}
