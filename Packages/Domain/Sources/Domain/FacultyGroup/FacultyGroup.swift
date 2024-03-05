//
//  FacultyGroup.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

public struct FacultyGroup: Identifiable, Hashable, Codable {
    public let name: String
    public var numberOfEvents: Int
    public let facultyDocument: String
    public let facultyUrl: String

    private var _isHidden: Bool?
    private var _color: FacultyGroupColor?

    public var isHidden: Bool {
        get { _isHidden ?? false }
        set { _isHidden = newValue }
    }

    public var color: FacultyGroupColor {
        get { _color ?? .default }
        set { _color = newValue }
    }

    public var id: String { name }

    public init(name: String, numberOfEvents: Int, facultyDocument: String, facultyUrl: String) {
        self.name = name
        self.numberOfEvents = numberOfEvents
        self.facultyDocument = facultyDocument
        self.facultyUrl = facultyUrl
    }
}

extension FacultyGroup: Equatable {
    public static func ==(lhs: FacultyGroup, rhs: FacultyGroup) -> Bool {
        lhs.name == rhs.name &&
        lhs.facultyDocument == rhs.facultyDocument &&
        lhs.facultyUrl == rhs.facultyUrl &&
        lhs.isHidden == rhs.isHidden &&
        lhs.color == rhs.color
    }
}
