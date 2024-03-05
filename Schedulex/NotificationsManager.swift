//
//  NotificationsManager.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/11/2023.
//

import Foundation
import NotificationCenter

@MainActor
final class NotificationsManager: ObservableObject {
    private let notificationCenter = UNUserNotificationCenter.current()
    @Published private(set) var areNotificationsSettingsLoaded = false
    @Published private(set) var canRequestNotificationsAccess = false
    @Published private(set) var isNotificationsAccessGrantedState: Bool?

    var isNotificationsAccessGranted: Driver<Bool> {
        $isNotificationsAccessGrantedState.compactMap { $0 }.removeDuplicates().asDriver()
    }

    func updateNotificationsPermission() async {
        let settings = await notificationCenter.notificationSettings()
        canRequestNotificationsAccess = settings.authorizationStatus == .notDetermined
        isNotificationsAccessGrantedState = settings.authorizationStatus == .authorized
        areNotificationsSettingsLoaded = true
    }

    func requestNotificationsPermission() async throws {
        try await notificationCenter.requestAuthorization(options: [.sound, .alert])
        await updateNotificationsPermission()
    }

    func removeAllPendingNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }

    func setNotifications(_ notifications: [LocalNotification]) async {
        removeAllPendingNotifications()
        for notification in notifications.prefix(64) {
            let notificationRequest = notification.toUNNotificationRequest()
            try? await notificationCenter.add(notificationRequest)
        }
    }
}
