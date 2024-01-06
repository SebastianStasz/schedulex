//
//  SettingsAppInformationsSection.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/12/2023.
//

import Resources
import SwiftUI
import Widgets

struct SettingsAppInformationsSection: View {
    let appVersion: String
    let isUpdateAvailable: Bool

    var body: some View {
        VStack(spacing: .large) {
            HStack(spacing: .large) {
                Image(.logoUek)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)

                SettingsLabel(title: "UEK Schedule", description: appVersionLabel)

                Button(appVersionButtonTitle, action: openAppInAppStore)
                    .buttonStyle(.appVersionButtonStyle)
                    .disabled(!isUpdateAvailable)
            }

            Separator()

            SettingsLabel(title: L10n.settingsContact, description: "sebastianstaszczyk.1999@gmail.com")
        }
        .card()
    }

    private var appVersionButtonTitle: String {
        isUpdateAvailable ? L10n.settingsAppVersionUpdate : L10n.settingsAppVersionInstalled
    }

    private var appVersionLabel: String {
        "\(L10n.settingsVersion) \(appVersion)"
    }

    private func openAppInAppStore() {
        let url = URL(string: "itms-apps://itunes.apple.com/app/id6468822571")!
        UIApplication.shared.open(url)
    }
}

#Preview {
    VStack(spacing: .large) {
        SettingsAppInformationsSection(appVersion: "1.0.12", isUpdateAvailable: false)
        SettingsAppInformationsSection(appVersion: "1.0.12", isUpdateAvailable: true)
    }
    .padding(.large)
}
