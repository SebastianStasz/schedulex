//
//  Presenter.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import UIKit

protocol Presenter {
    func push(_ viewController: UIViewController, animated: Bool)
    func pushReplacing(_ viewController: UIViewController, animated: Bool)
    func pushViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    func presentFullScreen(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func presentModally(_ viewController: UIViewController, animated: Bool)
    func backToViewController(firstWhere condition: (UIViewController) -> Bool, animated: Bool)
    func backToViewController(lastWhere condition: (UIViewController) -> Bool, animated: Bool)
    func backToRootViewController(animated: Bool)
    func popViewController(animated: Bool)
}

extension Presenter {
    func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }

    func pushReplacing(_ viewController: UIViewController) {
        pushReplacing(viewController, animated: true)
    }

    func presentFullScreen(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        presentFullScreen(viewController, animated: true, completion: completion)
    }

    func presentModally(_ viewController: UIViewController) {
        presentModally(viewController, animated: true)
    }

    func popViewController() {
        popViewController(animated: true)
    }

    func backToViewController(firstWhere condition: (UIViewController) -> Bool, animated: Bool = true) {
        backToViewController(firstWhere: condition, animated: animated)
    }

    func backToViewController(lastWhere condition: (UIViewController) -> Bool, animated: Bool = true) {
        backToViewController(lastWhere: condition, animated: animated)
    }

    func backToRootViewController() {
        backToRootViewController(animated: true)
    }
}
