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
    let isUpdateAvailable: Bool

    var body: some View {
        VStack(spacing: .large) {
            HStack(spacing: .large) {
                Image(.logoUek)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)

                SettingsLabel(title: "UEK Schedule", description: appVersion)

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

    private var appVersion: String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as? String
        return "\(L10n.settingsVersion) \(version ?? "")"
    }

    private func openAppInAppStore() {
        let url = URL(string: "itms-apps://itunes.apple.com/app/id6468822571")!
        UIApplication.shared.open(url)
    }
}

#Preview {
    VStack(spacing: .large) {
        SettingsAppInformationsSection(isUpdateAvailable: false)
        SettingsAppInformationsSection(isUpdateAvailable: true)
    }
    .padding(.large)
}
