//
//  Separator.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

public struct Separator: View {
    public init() {}

    public var body: some View {
        Rectangle()
            .fill(.backgroundPrimary)
            .frame(height: 1)
    }
}

#Preview {
    Separator()
}
