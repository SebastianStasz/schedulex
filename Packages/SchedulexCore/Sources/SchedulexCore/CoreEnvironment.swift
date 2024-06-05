//
//  CoreEnvironment.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import UIKit
import SchedulexFirebase

public protocol CoreEnvironment {
    var context: Context { get }
}

struct AppCoreEnvironment: CoreEnvironment {
    let context = Context(storage: FirestoreStorage(), appData: AppData())
}

public enum CoreEnvironmentHolder {
    static var currentCoreEnvironment: CoreEnvironment!

    public static func setup() {
        CoreEnvironmentHolder.currentCoreEnvironment = AppCoreEnvironment()
    }
}

public protocol CoreEnvironmentProvider {
    var coreEnvironment: CoreEnvironment { get }
}

extension CoreEnvironmentProvider {
    public var coreEnvironment: CoreEnvironment {
        CoreEnvironmentHolder.currentCoreEnvironment
    }
}

extension UIViewController: CoreEnvironmentProvider {}
