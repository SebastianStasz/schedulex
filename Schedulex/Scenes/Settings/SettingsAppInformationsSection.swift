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
    var body: some View {
        VStack(spacing: .large) {
            HStack(spacing: .large) {
                Image(.logoUek)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)

                SettingsLabel(title: "UEK Schedule", description: appVersion)
            }

            Separator()

            SettingsLabel(title: L10n.settingsContact, description: "sebastianstaszczyk.1999@gmail.com")

            Separator()

            Button(L10n.rateTheApp, action: openAppInAppStore)
        }
        .card()
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
    SettingsAppInformationsSection()
        .padding(.large)
}
