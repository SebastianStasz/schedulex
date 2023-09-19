//
//  ColorDesignSystemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

struct ColorDesignSystemView: View {
    var body: some View {
        DesignSystemView(title: "Colors") {
            ForEach(ColorStyle.allCases, id: \.name) { colorStyle in
                RoundedRectangle(cornerRadius: 12)
                    .fill(colorStyle.color)
                    .shadow(radius: .micro)
                    .frame(height: 80)
                    .designSystemComponent(name: colorStyle.name)
            }
        }
    }
}

#Preview {
    ColorDesignSystemView()
}
