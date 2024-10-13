//
//  EventWidgetCardView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/10/2024.
//

import Domain
import SwiftUI
import Widgets

struct EventWidgetCardView: View {
    @Environment(\.colorScheme) private var colorScheme
    let event: FacultyGroupEvent

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title, style: .footnote)
                .fontWeight(.semibold)

            Text(description, style: .footnote)
        }
        .foregroundStyle(.white)
        .lineLimit(1)
        .padding(.vertical, 4)
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundColor)
        .cornerRadius(.mini)
    }

    private var title: String {
        event.event.name ?? event.event.note ?? "Unknown"
    }

    private var description: String {
        let startTime = event.startDate.formatted(style: .timeOnly)
        let endTime = event.endDate.formatted(style: .timeOnly)
        return "\(startTime) - \(endTime)"
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? event.color.shade1 : event.color.shade2
    }
}

#Preview {
    EventWidgetCardView(event: .sample)
}
