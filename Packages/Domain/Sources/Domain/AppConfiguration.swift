//
//  AppConfiguration.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import Foundation

public struct AppConfiguration: Codable {
    public let latestAppVersion: String
    public let contactMail: String

    public static let defaultConfiguration = AppConfiguration(latestAppVersion: "", contactMail: "")
}
