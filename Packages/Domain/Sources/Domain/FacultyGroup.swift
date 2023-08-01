//
//  FacultyGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct FacultyGroup: Hashable, Decodable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
