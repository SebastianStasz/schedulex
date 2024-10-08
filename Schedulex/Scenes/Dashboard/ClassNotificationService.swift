//
//  ClassNotificationService.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 04/02/2024.
//

import Combine
import Domain
import Foundation
import SchedulexCore

@MainActor
struct ClassNotificationService {
    struct Input {
        let events: Driver<[Event]>
        let classNotificationsEnabled: Driver<Bool>
        let classNotificationsTime: Driver<ClassNotificationTime>
    }

    let notificationsManager: NotificationsManager

    func registerForEventsNotifications(input: Input) -> Driver<Void> {
        let areClassNotificationsEnabled = CombineLatest(input.classNotificationsEnabled, notificationsManager.isNotificationsAccessGranted)
            .map { $0 && $1 }

        let disableClassNotifications = areClassNotificationsEnabled
            .filter { !$0 }
            .perform { _ in notificationsManager.removeAllPendingNotifications() }

        let enableClassNotifications = CombineLatest3(input.events, input.classNotificationsTime, areClassNotificationsEnabled.filter { $0 })
            .map { events, notificationsTime, _ in
                filterAndMapToLocalNotification(events: events, time: notificationsTime)
            }
            .perform { await notificationsManager.setNotifications($0) }

        return Merge(disableClassNotifications, enableClassNotifications).asVoid()
    }

    private func filterAndMapToLocalNotification(events: [Event], time: ClassNotificationTime) -> [LocalNotification] {
        events.filter { !$0.isEventTransfer }.compactMap { $0.toLocalNotification(time: time) }
    }
}
