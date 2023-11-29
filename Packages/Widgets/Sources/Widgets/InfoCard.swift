//
//  InfoCard.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 29/11/2023.
//

import Foundation

public enum InfoCard {
    case enableNotifications

    var title: String {
        switch self {
        case .enableNotifications:
            return "Nie przegap zajęć!"
        }
    }

    var message: String {
        switch self {
        case .enableNotifications:
            return "Otrzymuj powiadomienia 5 minut przed rozpoczęciem zajęć."
        }
    }
}
