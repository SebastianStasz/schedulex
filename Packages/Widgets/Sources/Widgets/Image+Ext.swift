//
//  Image+Ext.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import SwiftUI

public extension Image {
    static func icon(_ icon: Icon) -> Image {
        Image(systemName: icon.name)
    }
}
