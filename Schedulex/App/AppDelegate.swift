//
//  AppDelegate.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/10/2023.
//

import FirebaseCore
import Resources
import SchedulexCore
import UIKit
import Widgets

@main
final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        CoreEnvironmentHolder.setup()
        configureBackButtonAppearance()
        configureNavigationBarTitle()
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    static func setUIBarButtonItemColorToClear() {
        setBarButtonItemColor(to: .clear)
    }

    static func resetBarButtonItemColor() {
        setBarButtonItemColor(to: .textPrimary)
    }

    private static func setBarButtonItemColor(to color: UIColor) {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: UIControl.State.highlighted)
    }

    private func configureBackButtonAppearance() {
        var config = UIImage.SymbolConfiguration(paletteColors: [.label])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18, weight: .medium)))

        let backButtonImage = UIImage(systemName: "arrow.backward", withConfiguration: config)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0))

        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        AppDelegate.setUIBarButtonItemColorToClear()
    }

    private func configureNavigationBarTitle() {
        let titleFont = UIFont.systemFont(ofSize: 21, weight: .bold)
        let titleAttributes = [NSAttributedString.Key.font: titleFont]
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
    }
}
