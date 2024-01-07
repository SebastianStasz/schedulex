//
//  SettingsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/11/2023.
//

import SwiftUI
import Widgets
import Resources

struct SettingsView: View {
    @AppStorage("appColorScheme") private var appColorScheme: AppColorScheme = .system
    let appVersion: String
    let contactMail: String
    let isUpdateAvailable: Bool

    var body: some View {
        VStack(spacing: .large) {
            SettingsAppInformationsSection(appVersion: appVersion, contactMail: contactMail, isUpdateAvailable: isUpdateAvailable)
            MenuPicker(title: L10n.settingsAppThemeTitle, options: AppColorScheme.allCases, selectedOption: $appColorScheme).card()
            ClassNotificationsToggle()
            Spacer()
        }
        .padding(.large)
        .navigationTitle(L10n.settingsTitle)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { toolbarContent }
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) { TextButton("") { } }
    }
}

#Preview {
    NavigationStack {
        SettingsView(appVersion: "1.0.12", contactMail: "sebastianstaszczyk.1999@gmail.com", isUpdateAvailable: false)
    }
}
