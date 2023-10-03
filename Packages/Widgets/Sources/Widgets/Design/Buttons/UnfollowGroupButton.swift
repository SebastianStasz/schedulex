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
    private let destructive: Bool

    public init(destructive: Bool = true, action: @escaping () -> Void) {
        self.destructive = destructive
        self.action = action
    }

    public var body: some View {
        Button(role: role, action: action) {
            Label(L10n.unfollow, systemImage: Icon.delete.name)
        }
        .tint(.red)
    }

    private var role: ButtonRole? {
        destructive ? .destructive : nil
    }
}
