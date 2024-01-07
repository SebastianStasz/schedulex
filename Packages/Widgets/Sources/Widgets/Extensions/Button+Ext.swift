//
//  Button+Ext.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 07/01/2024.
//

import SwiftUI

public extension Button where Label == SwiftUI.Label<SwiftUI.Text, Image> {
    init(_ title: String, icon: Icon, action: @escaping () -> Void) {
        self.init(title, systemImage: icon.name, action: action)
    }
}
