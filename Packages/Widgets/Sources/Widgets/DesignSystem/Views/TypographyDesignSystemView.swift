//
//  TypographyDesignSystemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

struct TypographyDesignSystemView: View {
    var body: some View {
        DesignSystemView(title: "Typography") {
            ForEach(Typography.allCases, id: \.name) { typography in
                Text(typography.name, style: typography)
            }
        }
    }
}

#Preview {
    TypographyDesignSystemView()
}
