//
//  NotificationCenter+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 03/02/2024.
//

import Combine
import UIKit

extension NotificationCenter {
    static var willEnterForeground: AnyPublisher<Void, Never> {
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .asVoid()
    }

    static var didEnterBackground: AnyPublisher<Void, Never> {
        NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
            .asVoid()
    }
}
