//
//  FollowGroupButton.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 22/09/2024.
//

import Resources
import SwiftUI

public struct FollowGroupButton: View {
    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Label(L10n.addToObserved, systemImage: Icon.plusCircle.name)
        }
        .tint(.greenPrimary)
    }
}
