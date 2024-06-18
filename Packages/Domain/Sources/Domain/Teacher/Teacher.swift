//
//  Teacher.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct Teacher: Decodable, Identifiable {
    public let fullName: String
    public let degree: String?
    public let numberOfEvents: Int
    public let eventsUrl: String

    public var id: String { fullName }
}
