//
//  AppDelegate.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/10/2023.
//

import FirebaseCore
import Resources
import UIKit
import Widgets

@main
final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        CoreEnvironmentHolder.setup()
        configureBackButtonAppearance()
        configureNavigationBarTitle()
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    private func configureBackButtonAppearance() {
        var config = UIImage.SymbolConfiguration(paletteColors: [.label])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18, weight: .medium)))

        let backButtonImage = UIImage(systemName: "chevron.backward", withConfiguration: config)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0))

        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
    }

    private func configureNavigationBarTitle() {
        let titleFont = UIFont.systemFont(ofSize: 21, weight: .bold)
        let titleAttributes = [NSAttributedString.Key.font: titleFont]
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
    }
}
