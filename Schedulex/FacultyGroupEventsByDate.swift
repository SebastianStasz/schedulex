//
//  FacultyGroupEventsByDate.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Foundation

struct FacultyGroupEventsByDate: Codable {
    let date: Date
    let events: [FacultyGroupEvent]
}
