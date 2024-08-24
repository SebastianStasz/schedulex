//
//  SettingsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/11/2023.
//

import Resources
import SchedulexCore
import SchedulexViewModel
import SwiftUI
import Widgets

struct SettingsView: RootView {
    @ObservedObject var store: SettingsStore

    var rootBody: some View {
        ScrollView {
            VStack(spacing: 40) {
                SettingsAppInformationsSection(appVersion: store.appVersion, contactMail: store.contactMail, isUpdateAvailable: store.isUpdateAvailable, sendEmailAction: store.presentSendEmailSheet)

                VStack(spacing: .medium) {
                    sectionHeader(L10n.settingsSectionHeaderNotifications)

                    ClassNotificationsToggle(areNotificationsEnabled: store.notificationsToggle, classNotificationsTime: $store.classNotificationsTime, isEnableNotificationsAlertPresented: $store.isEnableNotificationsAlertPresented)
                }

                VStack(spacing: .medium) {
                    sectionHeader(L10n.settingsSectionHeaderConfiguration)

                    VStack(spacing: .large) {
                        MenuPicker(title: L10n.settingsAppThemeTitle, options: AppColorScheme.allCases, selectedOption: $store.appColorScheme)

                        Separator()

                        HStack(spacing: .micro) {
                            Text(L10n.settingsLanguageTitle, style: .body)
                                .foregroundStyle(.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(store.appLanguage.name, style: .body)
                                .foregroundStyle(.accentPrimary)
                                .contentShape(Rectangle())
                                .onTapGesture(perform: openSettings)
                        }
                    }
                    .card()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.large)
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title, style: .footnote)
            .foregroundStyle(.grayShade1)
            .frame(maxWidth: .infinity, alignment: .leading)
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
