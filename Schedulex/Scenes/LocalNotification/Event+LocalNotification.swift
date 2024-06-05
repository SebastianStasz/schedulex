//
//  Event+LocalNotification.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/12/2023.
//

import Domain
import Foundation
import Resources
import SchedulexCore

extension Event {
    func toLocalNotification(time: ClassNotificationTime) -> LocalNotification? {
        guard let notificationDateComponents = notificationDateComponents(time: time) else { return nil }
        let id = UUID().uuidString
        let title = name ?? L10n.eventNotificationTitle
        let subtitle = notificationSubtitle(time: time)
        return LocalNotification(id: id, title: title, subtitle: subtitle, description: notificationDescription, dateComponents: notificationDateComponents)
    }

    private func notificationDateComponents(time: ClassNotificationTime) -> DateComponents? {
        guard let startDate, let date = Calendar.current.date(byAdding: .minute, value: -time.minutes, to: startDate) else { return nil }
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    }

    private func notificationSubtitle(time: ClassNotificationTime) -> String {
        switch time {
        case .oneHourBefore:
            return L10n.eventNotificationSubtitleHour
        default:
            return "\(L10n.eventNotificationSubtitlePrefix) \(time.minutes) \(L10n.minutesSuffix)"
        }
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
