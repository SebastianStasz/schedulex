//
//  CornerRadiusDesignSystemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

struct CornerRadiusDesignSystemView: View {
    var body: some View {
        DesignSystemView(title: "Corder radius") {
            ForEach(CornerRadius.allCases, id: \.value) { radius in
                Rectangle()
                    .fill(.grayShade1)
                    .frame(height: 60)
                    .cornerRadius(radius)
                    .designSystemComponent(name: getName(for: radius))
            }
        }
    }

    private func getName(for radius: CornerRadius) -> String {
        "\(radius.rawValue) - \(Int(radius.value))"
    }
}

#Preview {
    CornerRadiusDesignSystemView()
}
