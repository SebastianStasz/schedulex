//
//  FacultyGroup+Ext.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Domain

extension FacultyGroup {
    var isLanguage: Bool {
        name.hasPrefix("CJ")
    }
}
