//
//  UINavigationController+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 14/01/2024.
//

import UIKit

extension UINavigationController {
    func push(_ viewController: UIViewController, animated: Bool = true) {
        pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool = true) {
        popViewController(animated: animated)
    }

    func presentModally(_ viewController: UIViewController, animated: Bool = true) {
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: animated)
    }

    func dismiss(animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }
}
