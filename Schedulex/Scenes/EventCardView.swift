//
//  EventCardView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 20/09/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            HStack(alignment: .top, spacing: .medium) {
                VStack(alignment: .leading, spacing: .micro) {
                    Text(event.startDate?.formatted(style: .timeOnly) ?? "", style: .time)
                    Text(event.endDate?.formatted(style: .timeOnly) ?? "", style: .time)
                }
                .foregroundStyle(.blueShade1)
                .font(.note)

                VStack(alignment: .leading, spacing: .small) {
                    Text(event.name ?? "", style: .bodyMedium)
                        .lineLimit(2)
                        .foregroundStyle(.blueShade1)

                    VStack(alignment: .leading, spacing: .micro) {
                        Text(event.teacher ?? "", style: .footnote)
                        Text(event.place ?? "", style: .footnote)
                        HStack(spacing: 0) {
                            Text(event.type ?? "", style: .footnote)
                            Spacer()
                            TimelineView(.periodic(from: .now, by: 1)) { _ in
                                Text(status, style: .time)
                            }
                        }
                    }
                    .foregroundStyle(.blueShade2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.medium)
            .background(.blueShade4)
        }
        .padding(.leading, .medium)
        .background(.blueShade3)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var status: String {
        guard let startDate = event.startDate, let endDate = event.endDate else { return "" }
        if endDate <= .now {
            return L10n.eventFinished
        } else {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            let isBeforeEvent = startDate > .now
            let date = isBeforeEvent ? startDate : endDate
            let prefix = isBeforeEvent ? "" : "\(L10n.eventFinishingIn) "
            let description = formatter.localizedString(for: date, relativeTo: .now)
            return prefix + description
        }
    }
}

#Preview {
    EventCardView(event: .sample)
        .padding()
}
