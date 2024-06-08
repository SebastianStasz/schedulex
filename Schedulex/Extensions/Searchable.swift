//
//  Searchable.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 08/06/2024.
//


import Domain

protocol Searchable {
    var name: String { get }
}

extension Array where Element: Searchable {
    func filterUserSearch(text: String) -> Self {
        filterUserSearch(text: text, by: { $0.name })
    }
}

extension Faculty: Searchable {}
extension Pavilion: Searchable {}
extension Classroom: Searchable {}
