//
//  SceneDelegate.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Domain
import Combine
import UIKit
import Resources

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var navigator: AppNavigator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FontFamily.registerAllCustomFonts()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            navigator = AppNavigator(window: window)
            window.makeKeyAndVisible()
        }
    }
}
