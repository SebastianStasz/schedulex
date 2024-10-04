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
    case rateTheApplication

    public var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .enableNotifications:
            return L10n.infoCardEnableNotificationsTitle
        case .rateTheApplication:
            return L10n.infoCardRateTheAppTitle
        }
    }

    var message: String {
        switch self {
        case .enableNotifications:
            return L10n.infoCardEnableNotificationsDescription
        case .rateTheApplication:
            return L10n.infoCardRateTheAppDescription
        }
    }

    var buttonTitle: String {
        switch self {
        case .enableNotifications:
            return L10n.infoCardEnableNotificationsButton
        case .rateTheApplication:
            return L10n.infoCardRateTheAppButton
        }
    }
}
