//
//  UIApplication+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 03/02/2024.
//

import UIKit

extension UIApplication {
    func openAppInAppStore() {
        let url = URL(string: "itms-apps://itunes.apple.com/app/id6468822571")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
