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
    @Published private(set) var canRequestNotificationsAccess: Bool?
    @Published private(set) var isNotificationsAccessGranted: Bool?

    func updateNotificationsPermission() async {
        let settings = await notificationCenter.notificationSettings()
        canRequestNotificationsAccess = settings.authorizationStatus == .notDetermined
        isNotificationsAccessGranted = settings.authorizationStatus == .authorized
        areNotificationsSettingsLoaded = true
    }

    func requestNotificationsPermission() async throws {
        try await notificationCenter.requestAuthorization(options: [.sound, .alert])
        await updateNotificationsPermission()
    }

    func setNotifications(_ notifications: [LocalNotification]) async {
        notificationCenter.removeAllPendingNotificationRequests()
        for notification in notifications {
            let notificationRequest = notification.toUNNotificationRequest()
            try? await notificationCenter.add(notificationRequest)
        }
        // DEBUG
        let noti = await notificationCenter.pendingNotificationRequests()
        print(noti)
    }
}
