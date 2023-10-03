//
//  Separator.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

public struct Separator: View {
    private let height: CGFloat

    public init(height: CGFloat = 1) {
        self.height = height
    }

    public var body: some View {
        Rectangle()
            .fill(.backgroundPrimary)
            .frame(height: height)
    }
}

#Preview {
    Separator()
}
