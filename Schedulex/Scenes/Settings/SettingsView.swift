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

    var body: some View {
        VStack(spacing: .large) {
            SettingsAppInformationsSection(isUpdateAvailable: false)
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
        SettingsView()
    }
}
