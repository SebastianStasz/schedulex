//
//  AppColorScheme.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/12/2023.
//

import Resources
import SwiftUI
import Widgets

public enum AppColorScheme: String, Identifiable, CaseIterable, Pickable {
    case system
    case light
    case dark

    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .system:
            return L10n.settingsAppThemeSystemTitle
        case .light:
            return L10n.settingsAppThemeLightTitle
        case .dark:
            return L10n.settingsAppThemeDarkTitle
        }
    }

    public var scheme: UIUserInterfaceStyle {
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
