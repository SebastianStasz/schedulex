//
//  AppLanguage.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/03/2024.
//

import Foundation
import Resources

enum AppLanguage: String {
    case pl
    case en
    case ru
    case uk

    var name: String {
        switch self {
        case .pl:
            return L10n.settingsLanguagePolish
        case .en:
            return L10n.settingsLanguageEnglish
        case .ru:
            return L10n.settingsLanguageRussian
        case .uk:
            return L10n.settingsLanguageUkrainian
        }
    }

    static var firstPreferredLanguageOrDefault: AppLanguage {
        Locale.preferredLanguages[safe: 0]?.toLanguage() ?? .en
    }
}

private extension String {
    func toLanguage() -> AppLanguage? {
        let code = String(prefix(2))
        return AppLanguage(rawValue: code)
    }
}
