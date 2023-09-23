//
//  Faculty.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct Faculty: Hashable, Decodable {
    public let name: String
    public let type: FacultyType
    public let groups: [FacultyGroup]

    public var numberOfGroups: Int {
        groups.count
    }

    enum CodingKeys: CodingKey {
        case faculty, groups, type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .faculty)
        type = try container.decode(FacultyType.self, forKey: .type)
        groups = try container.decode([FacultyGroup].self, forKey: .groups)
    }

    public init(name: String, type: FacultyType, groups: [FacultyGroup]) {
        self.name = name
        self.type = type
        self.groups = groups
    }
}
