//
//  TabBarController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let dashboardNavigationController = createDashboardNavigationViewController()
        let uekNavigationController = createSchoolNavigationViewController()

        dashboardNavigationController.setTabBarItem(title: "Dashboard", icon: .tabBar1, tag: 0)
        uekNavigationController.setTabBarItem(title: "Uek", icon: .tabBar2, tag: 1)

        viewControllers = [dashboardNavigationController, uekNavigationController]
    }

    private func createDashboardNavigationViewController() -> UIViewController {
        let navigationController = createNavigationController()
        let viewModel = DashboardViewModel()
        let viewController = DashboardViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        return navigationController
    }

    private func createSchoolNavigationViewController() -> UIViewController {
        let navigationController = createNavigationController()
        let viewModel = SchoolViewModel()
        let viewController = SchoolViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        return navigationController
    }

    func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
