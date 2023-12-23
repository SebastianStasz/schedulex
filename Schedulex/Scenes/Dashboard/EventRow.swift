//
//  EventRow.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Domain
import SwiftUI
import Widgets

struct EventRow: View {
    let event: Event
    let isFirst: Bool
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: .medium) {
            VStack(alignment: .leading, spacing: .micro) {
                Text(event.startDate?.formatted(style: .timeOnly) ?? "", style: .timeMedium)
                    .foregroundStyle(.textPrimary)

                Text(event.endDate?.formatted(style: .timeOnly) ?? "", style: .time)
                    .foregroundStyle(.textSecondary)
            }

            VStack(spacing: 0) {
                Image.icon(isEnded ? .circleFill : .circle)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .padding(.top, isFirst ? 0 : 5)
                    .padding(.bottom, 5)

                Rectangle()
                    .frame(width: 1)

                if isLast {
                    Rectangle()
                        .frame(width: 12, height: 1)
                }
            }
            .foregroundStyle(.accentPrimary)

            EventCardView(event: event)
                .padding(.bottom, isLast ? 0 : .medium)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private var isEnded: Bool {
        event.status == nil
    }
}

#Preview {
    EventRow(event: .sample, isFirst: true, isLast: true)
}
