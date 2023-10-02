//
//  SchedulexApp.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Domain
import SwiftUI

@main
struct SchedulexApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
