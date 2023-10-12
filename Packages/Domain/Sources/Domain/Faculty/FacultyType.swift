//
//  FacultyType.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 23/09/2023.
//

import Foundation

public enum FacultyType: String, Decodable {
    case faculty = "FACULTY"
    case global = "GLOBAL"
    case other = "OTHER"
}
