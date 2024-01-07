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
        HStack(spacing: .medium) {
            VStack(alignment: .leading, spacing: .small) {
                HStack(spacing: .micro) {
                    Text(event.name ?? "", style: .bodyMedium)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "info.square")
                }
                .foregroundStyle(event.facultyGroupColor.shade1)

                VStack(alignment: .leading, spacing: .micro) {
                    Text(event.teacher ?? "", style: .footnote)

                    if !event.isEventTransfer {
                        Text(event.place ?? "", style: .footnote)
                    }

                    HStack(spacing: 0) {
                        Text(event.typeDescription, style: .footnote)
                            .foregroundStyle(event.isEventTransfer ? .red : event.facultyGroupColor.shade2)

                        Spacer()

                        if let status, !event.isEventTransfer {
                            Text(status, style: .footnote)
                        }
                    }
                }
                .foregroundStyle(event.facultyGroupColor.shade2)
            }
        }
        .lineLimit(1, reservesSpace: true)
        .padding(.medium)
        .background(event.facultyGroupColor.shade4)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var status: String? {
        guard let startDate = event.startDate, let endDate = event.endDate else { return nil }
        if endDate <= .now {
            return nil
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
    VStack(spacing: .large) {
        EventCardView(event: .sample)
        EventCardView(event: .eventTransfer)
    }
    .padding(.large)
}
