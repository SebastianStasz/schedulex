//
//  FacultyGroupColor.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 12/10/2023.
//

import SwiftUI

public enum FacultyGroupColor: String, Identifiable, CaseIterable, Codable {
    case blue
    case orange
    case purple
    case green
    case red
    case yellow

    public var id: String { rawValue }

    public static var `default`: FacultyGroupColor {
        .blue
    }
}
