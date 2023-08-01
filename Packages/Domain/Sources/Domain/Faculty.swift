//
//  Faculty.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct Faculty: Hashable, Decodable {
    public let name: String
    public let groups: [FacultyGroup]

    public var numberOfGroups: Int {
        groups.count
    }

    enum CodingKeys: CodingKey {
        case faculty, groups
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .faculty)
        groups = try container.decode([FacultyGroup].self, forKey: .groups)
    }

    public init(name: String, groups: [FacultyGroup]) {
        self.name = name
        self.groups = groups
    }
}
