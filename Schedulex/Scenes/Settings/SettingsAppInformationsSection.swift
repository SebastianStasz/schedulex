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
    @StateObject private var emailPresenter = SendEmailPresenter()
    let appVersion: String
    let contactMail: String
    let isUpdateAvailable: Bool

    var body: some View {
        VStack(spacing: .large) {
            HStack(spacing: .large) {
                Image(.logoUek)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)

                SettingsLabel(title: "UEK Schedule", description: appVersionLabel)

                Button(appVersionButtonTitle, action: UIApplication.shared.openAppInAppStore)
                    .buttonStyle(.appVersionButtonStyle)
                    .disabled(!isUpdateAvailable)
            }

            Separator()

            SettingsLabel(title: L10n.settingsContact, description: contactMail, outstanding: true)
                .onTapGesture { emailPresenter.sendMail(emailContent: emailContent) }
        }
        .card()
        .sheet(isPresented: $emailPresenter.isSendEmailViewPresented) {
            SendEmailView(emailContent: emailContent)
        }
    }

    private var appVersionButtonTitle: String {
        isUpdateAvailable ? L10n.settingsAppVersionUpdate : L10n.settingsAppVersionInstalled
    }

    private var appVersionLabel: String {
        "\(L10n.settingsVersion) \(appVersion)"
    }

    private var emailContent: EmailContent {
        .defaultContact(recipient: contactMail, appVersion: appVersion)
    }
}

#Preview {
    VStack(spacing: .large) {
        SettingsAppInformationsSection(appVersion: "1.0.12", contactMail: "sebastianstaszczyk.1999@gmail.com", isUpdateAvailable: false)
        SettingsAppInformationsSection(appVersion: "1.0.12", contactMail: "sebastianstaszczyk.1999@gmail.com", isUpdateAvailable: true)
    }
    .padding(.large)
}
