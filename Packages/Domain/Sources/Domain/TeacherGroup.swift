//
//  TeacherGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct TeacherGroup: Decodable {
    public let group: String
    public let teachers: [Teacher]
}
