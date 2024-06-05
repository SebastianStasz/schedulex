//
//  UIViewController+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import SwiftUI
import Widgets

extension UIViewController {
    func addCloseButton() {
        let image = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(dismissWithAnimation))
        closeButton.tintColor = .textPrimary
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc func dismissWithAnimation() {
        dismiss(animated: true)
    }
}
