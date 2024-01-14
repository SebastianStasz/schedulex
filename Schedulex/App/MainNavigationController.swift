//
//  MainNavigationController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import Combine
import SwiftUI

final class MainNavigationController: UINavigationController {
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.prefersLargeTitles = true

        coreEnvironment.context.$appData
            .map { $0.subscribedFacultyGroups.isEmpty }
            .removeDuplicates()
            .sink { [weak self] in
                if $0 {
                    self?.setIntroductionView()
                } else {
                    self?.setDashboardView()
                }
            }
            .store(in: &cancellables)
    }

    private func setIntroductionView() {
        let view = IntroductionView(onContinue: presentOnboardingFlow)
        let viewController = UIHostingController(rootView: view)
        setNavigationBarHidden(true, animated: false)
        setViewControllers([viewController], animated: false)
    }

    private func setDashboardView() {
        let viewModel = DashboardViewModel(navigationController: self)
        let viewController = DashboardViewController(viewModel: viewModel)
        setNavigationBarHidden(false, animated: false)
        setViewControllers([viewController], animated: false)
        dismiss()
    }

    private func presentOnboardingFlow() {
        let navigationController = UINavigationController()
        let viewModel = OnboardingFirstStepViewModel(navigationController: navigationController, onFinishOnboarding: setDashboardView)
        let viewController = OnboardingFirstStepViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.prefersLargeTitles = true
        present(navigationController, animated: true)
    }
}

