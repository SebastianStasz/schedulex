//
//  AppNavigator.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import SwiftUI

final class AppNavigator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        let navigationController = UINavigationController()
        let presentOnboardingFlow = { [unowned self] in
            let onboardingNavigationController = makeOnboardingFlowNavigationController()
            navigationController.present(onboardingNavigationController, animated: true)
        }
        let introductionView = IntroductionView(onContinue: presentOnboardingFlow)
        let introductionViewController = UIHostingController(rootView: introductionView)
        navigationController.setViewControllers([introductionViewController], animated: false)
        window.rootViewController = navigationController
    }

    private func makeOnboardingFlowNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        let viewModel = OnboardingFirstStepViewModel(navigationController: navigationController) { [weak self] in
            self?.window.rootViewController = UIHostingController(rootView: DashboardView())
        }
        let viewController = OnboardingFirstStepViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
