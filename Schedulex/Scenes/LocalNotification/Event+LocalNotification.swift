//
//  Event+LocalNotification.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/12/2023.
//

import Domain
import Foundation
import Resources

extension Event {
    func toLocalNotification(time: ClassNotificationTime) -> LocalNotification? {
        guard let notificationDateComponents = notificationDateComponents(time: time) else { return nil }
        let id = UUID().uuidString
        let title = name ?? L10n.eventNotificationTitle
        return LocalNotification(id: id, title: title, subtitle: L10n.eventNotificationSubtitle, description: notificationDescription, dateComponents: notificationDateComponents)
    }

    private func notificationDateComponents(time: ClassNotificationTime) -> DateComponents? {
        guard let startDate, let date = Calendar.current.date(byAdding: .minute, value: -time.minutes, to: startDate) else { return nil }
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    }

    private var notificationDescription: String? {
        var description = type ?? ""
        if let teacher {
            let prefix = description.isEmpty ? "" : ", "
            description.append(prefix + teacher)
        }
        if let place {
            let prefix = description.isEmpty ? "" : ", "
            description.append(prefix + place)
        }
        return description
    }
}
