//
//  SchedulexApp.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Firebase
import SwiftUI
import Widgets

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        configureBackButtonAppearance()
        return true
    }

    private func configureBackButtonAppearance() {
        var config = UIImage.SymbolConfiguration(paletteColors: [.label])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18, weight: .medium)))

        let backButtonImage = UIImage(systemName: "arrow.backward", withConfiguration: config)?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0))

        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
    }
}

@main
struct SchedulexApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
