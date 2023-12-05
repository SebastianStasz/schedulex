//
//  InfoCard.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 29/11/2023.
//

import Foundation
import Resources

public enum InfoCard: String, Identifiable, Codable, CaseIterable {
    case enableNotifications

    public var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .enableNotifications:
            return L10n.infoCardEnableNotificationsTitle
        }
    }

    var message: String {
        switch self {
        case .enableNotifications:
            return L10n.infoCardEnableNotificationsDescription
        }
    }

    var buttonTitle: String {
        switch self {
        case .enableNotifications:
            return L10n.infoCardEnableNotificationsButton
        }
    }
}
