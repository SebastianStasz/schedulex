//
//  SettingsViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 16/01/2024.
//

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

    fileprivate let enableNotifications = DriverSubject<Void>()
    fileprivate let disableNotifications = DriverSubject<Void>()
}

struct SettingsViewModel: ViewModel {
    let notificationsManager: NotificationsManager
    weak var navigationController: UINavigationController?

    func makeStore(context: Context) -> SettingsStore {
        let store = SettingsStore()

        store.appVersion = appVersion ?? ""
        store.appColorScheme = context.appData.appColorScheme
        store.classNotificationsTime = context.appData.classNotificationsTime

        context.storage.appConfiguration
            .sinkAndStore(on: store) {
                $0.contactMail = $1.contactMail
                $0.isUpdateAvailable = $1.latestAppVersion != appVersion
            }

        Merge(store.viewWillAppear, NotificationCenter.willEnterForeground)
            .perform { await notificationsManager.updateNotificationsPermission() }
            .sink {}.store(in: &store.cancellables)

        CombineLatest(context.$appData, notificationsManager.$isNotificationsAccessGranted)
            .map { $0.classNotificationsEnabled && ($1 ?? false) }
            .assign(to: &store.$areNotificationsEnabled)

        store.$classNotificationsTime
            .sink { context.appData.classNotificationsTime = $0 }
            .store(in: &store.cancellables)

        store.$appColorScheme
            .sink { context.appData.appColorScheme = $0 }
            .store(in: &store.cancellables)

        store.enableNotifications
            .perform { [weak store] in
                context.appData.classNotificationsEnabled = true
                if notificationsManager.canRequestNotificationsAccess {
                    try? await notificationsManager.requestNotificationsPermission()
                } else {
                    store?.isEnableNotificationsAlertPresented = true
                }
            }
            .sink {}.store(in: &store.cancellables)

        store.disableNotifications
            .perform {
                context.appData.classNotificationsEnabled = false
                notificationsManager.removeAllPendingNotifications()
            }
            .sink {}.store(in: &store.cancellables)

        return store
    }

    private var appVersion: String? {
        let dictionary = Bundle.main.infoDictionary
        return dictionary?["CFBundleShortVersionString"] as? String
    }
}
