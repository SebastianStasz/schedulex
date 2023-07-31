//
//  Faculty.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct Faculty: Identifiable, Decodable {
    public let name: String
    public let groups: [FacultyGroup]

    public var id: String { name }

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
}
