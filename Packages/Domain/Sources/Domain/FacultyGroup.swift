//
//  FacultyGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct FacultyGroup: Identifiable, Decodable {
    public let name: String

    public var id: String { name }
}
