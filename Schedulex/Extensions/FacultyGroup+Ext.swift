//
//  FacultyGroup+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 20/02/2024.
//

import Domain
import Foundation

extension Array where Element == FacultyGroup {
    func filterByNameAndSort(text: String) -> [FacultyGroup] {
        filterUserSearch(text: text, by: { $0.name })
            .sorted { group1, group2 in
                if group1.numberOfEvents != group2.numberOfEvents {
                    return group1.numberOfEvents != 0 && group2.numberOfEvents == 0
                } else {
                    return group1.name < group2.name
                }
            }
    }
}
