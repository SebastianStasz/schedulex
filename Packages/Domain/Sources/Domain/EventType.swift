//
//  EventType.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation

public enum EventType: String, Hashable, Decodable {
    case test
    case exam
    case lecture
    case colloquium
    case exercises
    case project
    case languageCourse
    case electiveLecture
    case tutorials
    case seminar
    case parlour
    case eventMoved
    case reservation
    case laboratory
    case electiveParlour
    case postgraduateStudies
    case electiveExercises
    case elearningExercises
}
