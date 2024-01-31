//
//  AppColorScheme.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/12/2023.
//

import SwiftUI
import Resources
import Widgets

enum AppColorScheme: String, Identifiable, CaseIterable, Pickable {
    case system
    case light
    case dark

    var id: String { 
        rawValue
    }

    var title: String {
        switch self {
        case .system:
            return L10n.settingsAppThemeSystemTitle
        case .light:
            return L10n.settingsAppThemeLightTitle
        case .dark:
            return L10n.settingsAppThemeDarkTitle
        }
    }

    var scheme: UIUserInterfaceStyle {
        switch self {
        case .system:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
