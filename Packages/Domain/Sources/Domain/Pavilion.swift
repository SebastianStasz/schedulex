//
//  Pavilion.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct Pavilion: Decodable, Identifiable {
    public let pavilion: String
    public let classrooms: [Classroom]

    public var numberOfClassrooms: Int {
        classrooms.count
    }

    public var id: String { pavilion }
}
