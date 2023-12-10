//
//  LocalNotification.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 04/12/2023.
//

import Domain
import NotificationCenter

struct LocalNotification {
    let id: String
    let title: String
    let subtitle: String?
    let description: String?
    let dateComponents: DateComponents

    func toUNNotificationRequest() -> UNNotificationRequest {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        return UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
    }

    private var notificationContent: UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.subtitle = subtitle ?? ""
        content.body = description ?? ""
        return content
    }
}
