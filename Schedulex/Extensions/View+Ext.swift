//
//  View+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/03/2024.
//

import SwiftUI

extension View {
    func openSettings() {
        if let bundle = Bundle.main.bundleIdentifier,
           let settings = URL(string: UIApplication.openSettingsURLString + bundle),
           UIApplication.shared.canOpenURL(settings)
        {
            UIApplication.shared.open(settings)
        }
    }
}
