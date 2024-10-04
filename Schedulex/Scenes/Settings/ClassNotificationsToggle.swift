//
//  ClassNotificationsToggle.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/12/2023.
//

import Resources
import SchedulexCore
import SwiftUI
import Widgets

struct ClassNotificationsToggle: View {
    @Binding var areNotificationsEnabled: Bool
    @Binding var classNotificationsTime: ClassNotificationTime
    @Binding var isEnableNotificationsAlertPresented: Bool

    var body: some View {
        VStack(spacing: .large) {
            HStack(spacing: .large) {
                Text(L10n.settingsClassNotificationsTitle, style: .body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.textPrimary)

                Toggle(L10n.settingsClassNotificationsTitle, isOn: $areNotificationsEnabled)
                    .labelsHidden()
            }

            if areNotificationsEnabled {
                Separator()
                LabeledPicker(title: L10n.settingsClassNotificationsTimeTitle, options: ClassNotificationTime.allCases, selectedOption: $classNotificationsTime)
            }
        }
        .card()
        .alert(L10n.settingsNotificationsAlertTitle, isPresented: $isEnableNotificationsAlertPresented) {
            Button(L10n.settingsNotificationsAlertGoToSettings, action: openSettings)
                .keyboardShortcut(.defaultAction)
            Button(L10n.settingsNotificationsAlertCancel, action: {})
                .keyboardShortcut(.cancelAction)
        } message: {
            Text(L10n.settingsNotificationsAlertDescription)
        }
    }
}

#Preview {
    ClassNotificationsToggle(
        areNotificationsEnabled: .constant(true),
        classNotificationsTime: .constant(.oneHourBefore),
        isEnableNotificationsAlertPresented: .constant(false)
    )
    .padding(.large)
}
