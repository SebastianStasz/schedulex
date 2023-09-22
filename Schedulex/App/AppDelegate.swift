//
//  AppDelegate.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Firebase
import UIKit
import Widgets

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configureBackButtonAppearance()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func configureBackButtonAppearance() {
        var config = UIImage.SymbolConfiguration(paletteColors: [.textPrimary])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18, weight: .medium)))

        let backButtonImage = UIImage(systemName: "arrow.backward", withConfiguration: config)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0))

        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
    }
}
