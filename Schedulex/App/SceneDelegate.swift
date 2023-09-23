//
//  SceneDelegate.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createDashboardNavigationViewController()
        window?.makeKeyAndVisible()
    }

    private func createDashboardNavigationViewController() -> UIViewController {
        let navigationController = createNavigationController()
        let presenter = NavigationPresenter(navigationController: navigationController)
        let viewModel = DashboardViewModel()
        let viewController = DashboardViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        return navigationController
    }

    private func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
