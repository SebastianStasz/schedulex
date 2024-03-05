//
//  CoreEnvironment.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import UIKit
import SchedulexFirebase

protocol CoreEnvironment {
    var context: Context { get }
}

struct AppCoreEnvironment: CoreEnvironment {
    let context = Context(storage: FirestoreStorage(), appData: AppData())
}

enum CoreEnvironmentHolder {
    static var currentCoreEnvironment: CoreEnvironment!

    static func setup() {
        CoreEnvironmentHolder.currentCoreEnvironment = AppCoreEnvironment()
    }
}

protocol CoreEnvironmentProvider {
    var coreEnvironment: CoreEnvironment { get }
}

extension CoreEnvironmentProvider {
    var coreEnvironment: CoreEnvironment {
        CoreEnvironmentHolder.currentCoreEnvironment
    }
}

extension UIViewController: CoreEnvironmentProvider {}
