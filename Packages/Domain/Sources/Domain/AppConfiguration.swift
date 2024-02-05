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

    public var currentAppVersion: String? {
        let dictionary = Bundle.main.infoDictionary
        return dictionary?["CFBundleShortVersionString"] as? String
    }

    public var isAppUpdateAvailable: Bool {
        latestAppVersion != currentAppVersion
    }

    public static let defaultConfiguration = AppConfiguration(latestAppVersion: "", contactMail: "")
}
