//
//  CornerRadius.swift
//  Wdigets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

enum CornerRadius: String, CaseIterable {
    case medium
    case large

    var value: CGFloat {
        switch self {
        case .medium:
            return 10
        case .large:
            return 12
        }
    }
}

extension View {
    func cornerRadius(_ radius: CornerRadius) -> some View {
        cornerRadius(radius.value)
    }
}
