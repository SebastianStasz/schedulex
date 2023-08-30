//
//  NavigationPresenter.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import UIKit

struct NavigationPresenter: Presenter {
    unowned let navigationController: UINavigationController

    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    func pushReplacing(_ viewController: UIViewController, animated: Bool) {
        guard viewController is UINavigationController == false else { return } // Avoid pushing UINavigationController onto stack
        push(viewController, animated: animated)
        let indexToRemove = navigationController.viewControllers.count - 2
        guard indexToRemove > 0 else { return }
        navigationController.viewControllers.remove(at: indexToRemove)
    }

    func pushViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        var newViewControllers = navigationController.viewControllers
        newViewControllers.append(contentsOf: viewControllers)
        navigationController.setViewControllers(newViewControllers, animated: animated)
    }

    func presentFullScreen(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    func presentModally(_ viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: animated)
    }

    func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    func backToViewController(firstWhere condition: (UIViewController) -> Bool, animated: Bool) {
        guard let viewController = navigationController.viewControllers.first(where: condition) else { return }
        navigationController.popToViewController(viewController, animated: animated)
    }

    func backToViewController(lastWhere condition: (UIViewController) -> Bool, animated: Bool) {
        guard let viewController = navigationController.viewControllers.last(where: condition) else { return }
        navigationController.popToViewController(viewController, animated: animated)
    }

    func backToRootViewController(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
}
