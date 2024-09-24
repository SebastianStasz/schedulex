//
//  UnfollowGroupButton.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 01/10/2023.
//

import Resources
import SwiftUI

public struct UnfollowGroupButton: View {
    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(role: .destructive, action: action) {
            Label(L10n.unfollow, systemImage: Icon.delete.name)
        }
    }
}
