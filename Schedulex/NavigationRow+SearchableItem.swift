//
//  NavigationRow+SearchableItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

extension NavigationRow where Content == EmptyView {
    init<Item: SearchableItem>(item: Item, action: @escaping () -> Void) {
        self.init(title: item.name, caption: item.caption, action: action)
    }
}
