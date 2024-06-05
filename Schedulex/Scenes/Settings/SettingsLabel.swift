//
//  SettingsLabel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/12/2023.
//

import SwiftUI
import Widgets

struct SettingsLabel: View {
    let title: String
    let description: String
    var outstanding = false

    var body: some View {
        VStack(alignment: .leading, spacing: .micro) {
            Text(title, style: .body)
                .foregroundStyle(.textPrimary)

            Text(description, style: .footnote)
                .foregroundStyle(outstanding ? .blue : .grayShade1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SettingsLabel(title: "Title", description: "Some description")
}
