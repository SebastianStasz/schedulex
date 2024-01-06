//
//  AppConfigurationService.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import Foundation
import SchedulexFirebase

final class AppConfigurationService: ObservableObject {
    @Published private(set) var isUpdateAvailable = false

    func subscribe(service: FirestoreService) {
        let currentAppVersion = appVersion

        service.subscribeToAppSettings()
            .compactMap { $0 }
            .map { $0.latestAppVersion != currentAppVersion }
            .assign(to: &$isUpdateAvailable)
    }

    var appVersion: String? {
        let dictionary = Bundle.main.infoDictionary
        return dictionary?["CFBundleShortVersionString"] as? String
    }
}
