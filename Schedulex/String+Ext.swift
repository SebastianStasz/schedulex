//
//  String+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Foundation

extension String {
    /// Returns `true` if `other` is non-empty and contained within `self` by
    /// case-insensitive, non-literal search. Otherwise, returns `false`.
    func containsCaseInsensitive(_ other: String) -> Bool {
        lowercased().contains(other.lowercased())
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

extension Array {
    func filterUserSearch(text: String, by getElement: (Element) -> String) -> [Element] {
        guard !text.isEmpty else { return self }
        return filter { getElement($0).containsCaseInsensitive(text) }
            .sorted(by: {
                let first = getElement($0).hasPrefix(text) ? 0 : 1
                let second = getElement($1).hasPrefix(text) ? 0 : 1
                return first < second
            })
    }
}
