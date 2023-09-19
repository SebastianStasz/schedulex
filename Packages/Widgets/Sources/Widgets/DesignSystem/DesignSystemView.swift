//
//  DesignSystemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

struct DesignSystemView<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .xlarge) {
                content()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.large)
        }
        .navigationTitle(title)
    }
}

#Preview {
    DesignSystemView(title: "View title") {
        Text("Custom content")
    }
}
