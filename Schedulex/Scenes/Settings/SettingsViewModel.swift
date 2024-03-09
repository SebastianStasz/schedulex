//
//  SettingsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 16/01/2024.
//

import MessageUI
import SwiftUI

final class SettingsStore: RootStore {
    @Published fileprivate var areNotificationsEnabled = false

    @Published fileprivate(set) var appVersion = ""
    @Published fileprivate(set) var contactMail = ""
    @Published fileprivate(set) var isUpdateAvailable = false

    @Published var classNotificationsTime: ClassNotificationTime = .oneHourBefore
    @Published var appColorScheme: AppColorScheme = .system
    @Published var isEnableNotificationsAlertPresented = false

    var notificationsToggle: Binding<Bool> {
        Binding(get: { self.areNotificationsEnabled },
                set: { $0 ? self.enableNotifications.send() : self.disableNotifications.send() })
    }

    var presentSendEmailSheet = {}

    fileprivate let enableNotifications = DriverSubject<Void>()
    fileprivate let disableNotifications = DriverSubject<Void>()
}

struct SettingsViewModel: ViewModel {
    let notificationsManager: NotificationsManager
    weak var navigationController: UINavigationController?

    func makeStore(context: Context) -> SettingsStore {
        let store = SettingsStore()

        store.appColorScheme = context.appData.appColorScheme
        store.classNotificationsTime = context.appData.classNotificationsTime

        context.storage.appConfiguration
            .sinkAndStore(on: store) {
                $0.contactMail = $1.contactMail
                $0.appVersion = $1.currentAppVersion ?? ""
                $0.isUpdateAvailable = $1.isAppUpdateAvailable
            }

        Merge(store.viewWillAppear, NotificationCenter.willEnterForeground)
            .perform { await notificationsManager.updateNotificationsPermission() }
            .sink {}.store(in: &store.cancellables)

        CombineLatest(context.appData.$classNotificationsEnabled, notificationsManager.isNotificationsAccessGranted)
            .map { $0 && $1 }
            .assign(to: &store.$areNotificationsEnabled)

        store.$classNotificationsTime
            .dropFirst()
            .sink { context.appData.classNotificationsTime = $0 }
            .store(in: &store.cancellables)

        store.$appColorScheme
            .dropFirst()
            .sink { context.appData.appColorScheme = $0 }
            .store(in: &store.cancellables)

        store.enableNotifications
            .perform { [weak store] in
                context.appData.classNotificationsEnabled = true
                if !(notificationsManager.isNotificationsAccessGrantedState ?? true) {
                    if notificationsManager.canRequestNotificationsAccess {
                        try? await notificationsManager.requestNotificationsPermission()
                    } else {
                        store?.isEnableNotificationsAlertPresented = true
                    }
                }
            }
            .sink {}.store(in: &store.cancellables)

        store.disableNotifications
            .perform {
                context.appData.classNotificationsEnabled = false
                notificationsManager.removeAllPendingNotifications()
            }
            .sink {}.store(in: &store.cancellables)

        store.presentSendEmailSheet = { [weak store] in
            presentSendEmailSheet(recipient: store?.contactMail, appVersion: store?.appVersion)
        }

        return store
    }

    private func presentSendEmailSheet(recipient: String?, appVersion: String?) {
        guard MFMailComposeViewController.canSendMail(),
              let emailContent = EmailContent.defaultContact(recipient: recipient, appVersion: appVersion) else {
            return
        }
        AppDelegate.resetBarButtonItemColor()
        let viewController = SendEmailViewController(emailContent: emailContent)
        navigationController?.presentModally(viewController)
    }
}
