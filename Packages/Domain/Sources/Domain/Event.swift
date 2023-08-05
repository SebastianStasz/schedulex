//
//  Event.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Foundation

public struct Event: Hashable, Decodable {
    public let time: String
    public let date: String
    public let name: String
    public let place: String?
    public let teacher: String
    public let type: EventType
}
