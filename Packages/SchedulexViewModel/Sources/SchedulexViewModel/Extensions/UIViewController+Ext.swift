//
//  UIViewController+Ext.swift
//  SchedulexViewModel
//
//  Created by Sebastian Staszczyk on 19/05/2024.
//

import SwiftUI

extension UIViewController {
    func display(_ childController: UIViewController, viewConfigurationHandler: ((UIView) -> Void)?) {
        addChild(childController)
        let childControllerView: UIView = childController.view
        view.addSubview(childControllerView)
        viewConfigurationHandler?(childControllerView)
        childController.didMove(toParent: self)
    }

    func displayChild(_ childViewController: UIViewController) {
        displayChild(childViewController, containerView: view)
    }

    func displayChild(_ childViewController: UIViewController, containerView: UIView) {
        addChild(childViewController)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childViewController.view)
        NSLayoutConstraint.activate([
            childViewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            childViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        childViewController.didMove(toParent: self)
    }

    func displayView(_ view: some View, containerView: UIView) {
        let hostingController = AnyHostingController(rootView: view)
        displayChild(hostingController, containerView: containerView)
    }

    func displayView(_ view: some View) {
        displayView(view, containerView: self.view)
    }
}
