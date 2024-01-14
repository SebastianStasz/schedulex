//
//  SceneDelegate.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import UIKit
import Resources

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FontFamily.registerAllCustomFonts()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = MainNavigationController()
            window.makeKeyAndVisible()
            self.window = window
        }
    }
}
