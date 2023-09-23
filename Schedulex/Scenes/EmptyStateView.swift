//
//  EmptyStateView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 22/09/2023.
//

import SwiftUI
import Widgets

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: .medium) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 26)

            Text("No results found", style: .body)
        }
        .foregroundStyle(.grayShade1)
    }
}

#Preview {
    EmptyStateView()
}
