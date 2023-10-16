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

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        configureBackButtonAppearance()
        configureNavigationBarTitle()
        return true
    }

    private func configureBackButtonAppearance() {
        var config = UIImage.SymbolConfiguration(paletteColors: [.label])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18, weight: .medium)))

        let backButtonImage = UIImage(systemName: "chevron.backward", withConfiguration: config)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0))

        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textPrimary], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textPrimary], for: UIControl.State.highlighted)
    }

    private func configureNavigationBarTitle() {
        let titleFont = UIFont.systemFont(ofSize: 21, weight: .bold)
        let titleAttributes = [NSAttributedString.Key.font: titleFont]
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
    }
}
