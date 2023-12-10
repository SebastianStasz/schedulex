//
//  ClassNotificationsToggle.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/12/2023.
//

import Resources
import SwiftUI
import Widgets

struct ClassNotificationsToggle: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject private var notificationsManager: NotificationsManager
    @State private var isEnableNotificationsAlertPresented = false
    @AppStorage("classNotificationsEnabled") private var classNotificationsEnabled = false

    private var areNotificationsEnabled: Binding<Bool> {
        Binding(get: { classNotificationsEnabled && (notificationsManager.isNotificationsAccessGranted ?? false) },
                set: { $0 ? enableClassNotifications() : disableClassNotifications() })
    }

    var body: some View {
        HStack(spacing: .large) {
            SettingsLabel(title: L10n.settingsEventsNotificationsTitle, description: L10n.infoCardEnableNotificationsDescription)

            Toggle(L10n.settingsEventsNotificationsTitle, isOn: areNotificationsEnabled)
                .labelsHidden()
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
        .onChange(of: scenePhase) { onSceneChange($0) }
        .onAppear { updateNotificationsPermission() }
    }

    private func disableClassNotifications() {
        classNotificationsEnabled = false
        notificationsManager.removeAllPendingNotifications()
    }

    private func enableClassNotifications() {
        classNotificationsEnabled = true
        guard !(notificationsManager.isNotificationsAccessGranted ?? true) else { return }
        if notificationsManager.canRequestNotificationsAccess ?? false {
            requestNotificationsPermission()
        } else {
            isEnableNotificationsAlertPresented = true
        }
    }
    
    private func onSceneChange(_ scene: ScenePhase) {
        guard scene == .active else { return }
        updateNotificationsPermission()
    }

    private func updateNotificationsPermission() {
        Task { await notificationsManager.updateNotificationsPermission() }
    }

    private func requestNotificationsPermission() {
        Task { try? await notificationsManager.requestNotificationsPermission() }
    }

    private func openSettings() {
        if let bundle = Bundle.main.bundleIdentifier, 
            let settings = URL(string: UIApplication.openSettingsURLString + bundle),
            UIApplication.shared.canOpenURL(settings) {
            UIApplication.shared.open(settings)
        }
    }
}

#Preview {
    ClassNotificationsToggle()
        .environmentObject(NotificationsManager())
}
