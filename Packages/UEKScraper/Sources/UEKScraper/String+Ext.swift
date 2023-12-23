//
//  String+Ext.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Foundation

extension String {
    func nilIfEmpty() -> String? {
        isEmpty ? nil : self
    }
}
