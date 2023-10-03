//
//  FacultyGroupClass.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 01/10/2023.
//

import Foundation

public struct FacultyGroupClass: Hashable, Codable {
    public let name: String
    public let type: String
    public let teacher: String

    public init(name: String, type: String, teacher: String) {
        self.name = name
        self.type = type
        self.teacher = teacher
    }
}
