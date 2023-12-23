//
//  Array+Ext.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
