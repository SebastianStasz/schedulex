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
            Rectangle()
                .frame(width: .medium)
                .foregroundStyle(event.facultyGroupColor.shade3)

            HStack(alignment: .top, spacing: .medium) {
                VStack(alignment: .leading, spacing: .micro) {
                    Text(event.startDate?.formatted(style: .timeOnly) ?? "", style: .time)
                    Text(event.endDate?.formatted(style: .timeOnly) ?? "", style: .time)
                }
                .foregroundStyle(event.facultyGroupColor.shade1)
                .font(.note)

                VStack(alignment: .leading, spacing: .small) {
                    Text(event.name ?? "", style: .bodyMedium)
                        .lineLimit(2)
                        .foregroundStyle(event.facultyGroupColor.shade1)

                    VStack(alignment: .leading, spacing: .micro) {
                        Text(event.teacher ?? "", style: .footnote)
                        Text(event.place ?? "", style: .footnote)
                        HStack(spacing: 0) {
                            Text(event.typeDescription, style: .footnote)
                                .foregroundStyle(event.isEventTransfer ? .red : event.facultyGroupColor.shade2)
                            Spacer()
                            if !event.isEventTransfer {
                                TimelineView(.periodic(from: .now, by: 1)) { _ in
                                    Text(status, style: .time)
                                }
                            }
                        }
                    }
                    .foregroundStyle(event.facultyGroupColor.shade2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.medium)
            .background(event.facultyGroupColor.shade4)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .fixedSize(horizontal: false, vertical: true)
        .opacity(event.isEventTransfer ? 0.5 : 1)
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
    VStack(spacing: .large) {
        EventCardView(event: .sample)
        EventCardView(event: .eventTransfer)
    }
    .padding(.large)
}
