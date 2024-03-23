//
//  AppLanguage.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/03/2024.
//

import Resources

enum AppLanguage: String {
    case pl
    case en

    var name: String {
        switch self {
        case .pl:
            return L10n.settingsLanguagePolish
        case .en:
            return L10n.settingsLanguageEnglish
        }
    }
}
