//
//  AppConfigurationService.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import Domain
import Foundation
import SchedulexFirebase

final class AppConfigurationService: ObservableObject {
    @Published private(set) var isUpdateAvailable = false
    @Published private(set) var configuration = AppConfiguration.defaultConfiguration

    func subscribe(service: FirestoreService) {
        let currentAppVersion = appVersion

        let appConfiguration = service.subscribeToAppConfiguration()
            .compactMap { $0 }

        appConfiguration
            .assign(to: &$configuration)

        appConfiguration
            .map { $0.latestAppVersion != currentAppVersion }
            .assign(to: &$isUpdateAvailable)
    }

    var appVersion: String? {
        let dictionary = Bundle.main.infoDictionary
        return dictionary?["CFBundleShortVersionString"] as? String
    }
}
