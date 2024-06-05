//
//  ClassNotificationTime.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 10/12/2023.
//

import Foundation
import Resources
import Widgets

public enum ClassNotificationTime: String, Identifiable, CaseIterable, Pickable {
    case fiveMinutesBefore
    case tenMinutesBefore
    case fifteenMinutesBefore
    case thirtyMinutesBefore
    case oneHourBefore

    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .oneHourBefore:
            return L10n.settingsClassNotificationsTimeHourBefore
        default:
            return "\(minutes) \(L10n.settingsClassNotificationsTimeMinutesBefore)"
        }
    }

    public var minutes: Int {
        switch self {
        case .fiveMinutesBefore:
            return 5
        case .tenMinutesBefore:
            return 10
        case .fifteenMinutesBefore:
            return 15
        case .thirtyMinutesBefore:
            return 30
        case .oneHourBefore:
            return 60
        }
    }
}
