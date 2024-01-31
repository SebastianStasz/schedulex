//
//  SettingsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/11/2023.
//

import SwiftUI
import Widgets
import Resources

struct SettingsView: RootView {
    @ObservedObject var store: SettingsStore

    var rootBody: some View {
        VStack(spacing: .large) {
            SettingsAppInformationsSection(appVersion: store.appVersion, contactMail: store.contactMail, isUpdateAvailable: store.isUpdateAvailable)
            MenuPicker(title: L10n.settingsAppThemeTitle, options: AppColorScheme.allCases, selectedOption: $store.appColorScheme).card()
            ClassNotificationsToggle(areNotificationsEnabled: store.notificationsToggle, classNotificationsTime: $store.classNotificationsTime, isEnableNotificationsAlertPresented: $store.isEnableNotificationsAlertPresented)
            Spacer()
        }
        .padding(.large)
    }
}

final class SettingsViewController: SwiftUIViewController<SettingsViewModel, SettingsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.settingsTitle
    }
}

#Preview {
    NavigationStack {
        SettingsView(store: SettingsStore())
    }
}
