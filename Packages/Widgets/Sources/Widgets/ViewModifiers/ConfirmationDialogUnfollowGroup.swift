//
//  ConfirmationDialogUnfollowGroup.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 22/09/2024.
//

import Resources
import SwiftUI

private struct ConfirmationDialogUnfollowGroup: ViewModifier {
    @Binding var isPresented: Bool
    let groupName: String
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .confirmationDialog(unfollowGroupQuestion, isPresented: $isPresented, titleVisibility: .visible) {
                Button(L10n.unfollow, role: .destructive, action: action)
            }
    }

    private var unfollowGroupQuestion: String {
        L10n.unfollowGroupQuestion + " \(groupName)?"
    }
}

public extension View {
    func confirmationDialogUnfollowGroup(name: String?, isPresented: Binding<Bool>, action: @escaping () -> Void) -> some View {
        modifier(ConfirmationDialogUnfollowGroup(isPresented: isPresented, groupName: name ?? "", action: action))
    }
}
