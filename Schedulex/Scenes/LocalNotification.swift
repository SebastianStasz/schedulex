//
//  LocalNotification.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 04/12/2023.
//

import Domain
import Foundation
import NotificationCenter

struct LocalNotification {
    let id: String
    let title: String
    let description: String
    let dateComponents: DateComponents

    func toUNNotificationRequest() -> UNNotificationRequest {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        return UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
    }

    private var notificationContent: UNNotificationContent {
        var content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        return content
    }
}

extension Event {
    func toLocalNotification() -> LocalNotification? {
        let name = name ?? "UEK Schedule event"
        let description = "Event by \(teacher ?? "")"
        guard let startDate else { return nil }
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: startDate)
        return LocalNotification(id: UUID().uuidString, title: name, description: description, dateComponents: dateComponents)
    }
}
