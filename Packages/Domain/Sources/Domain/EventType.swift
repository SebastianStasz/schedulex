//
//  EventType.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation

public enum EventType: String, Hashable, Decodable {
    case exam
    case lecture
    case excercises
    case languageCourse
    case tutorials
}
