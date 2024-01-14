//
//  ObservedFacultyGroupItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 12/10/2023.
//

import SwiftUI
import Widgets

struct ObservedFacultyGroupItem: View {
    let title: String
    let caption: String
    let color: Color
    let isSelected: Bool
    let trailingIconAction: () -> Void

    var body: some View {
        HStack(spacing: .large) {
            SelectionIcon(isSelected: isSelected, color: color)
                .frame(height: .xlarge)

            VStack(alignment: .leading, spacing: .micro) {
                Text(title, style: .body)
                    .foregroundStyle(.textPrimary)
                    .multilineTextAlignment(.leading)

                Text(caption, style: .footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: trailingIconAction) {
                Image.icon(.info)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.accentPrimary)
                    .frame(height: .xlarge)
            }
            .buttonStyle(.plain)
        }
        .card()
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: .large) {
        ObservedFacultyGroupItem(title: "ZIISS2-2311IS", caption: "76 events", color: .greenPrimary, isSelected: true, trailingIconAction: {})
        ObservedFacultyGroupItem(title: "ZIISS2-2311IS", caption: "76 events", color: .accentPrimary, isSelected: false, trailingIconAction: {})
    }
    .padding(.large)
}
