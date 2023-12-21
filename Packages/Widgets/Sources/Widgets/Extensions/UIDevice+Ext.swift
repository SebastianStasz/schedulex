//
//  UIDevice+Ext.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/12/2023.
//

import UIKit

public extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
