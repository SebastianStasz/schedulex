//
//  Classroom.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 07/06/2024.
//

import Foundation

public struct Classroom: Decodable, Identifiable {
    public let name: String
    public let url_suffix: String

    public var id: String { name }
}
