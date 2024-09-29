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
    @Environment(\.openURL) private var openURL

    let event: Event
    let color: FacultyGroupColor
    let currentDate: Date
    let isEventInProgress: Bool
    let isCancelled: Bool
    var isForFacultyGroup = true

    var body: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .leading, spacing: .small) {
                HStack(spacing: .micro) {
                    Text(event.nameLocalized, style: .bodyMedium)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "info.square")
                }
                .foregroundStyle(color.shade1)

                VStack(alignment: .leading, spacing: .micro) {
                    Text(event.teacher ?? "", style: .footnote)

                    if !event.isEventTransfer, !isCancelled {
                        Text(placeOrFacultyGroup, style: .footnote)
                    if isEventActive {
                            .opacity(showTeamsButton ? 0 : 1)
                    }

                    HStack(spacing: 0) {
                        Text(eventDescription, style: .footnote)
                            .foregroundStyle(event.isEventTransfer || isCancelled ? .red : color.shade2)
                            .opacity(showTeamsButton ? 0 : 1)

                        Spacer()

                        if let status, isEventActive {
                            Text(status, style: .footnote)
                        }
                    }
                }
                .foregroundStyle(color.shade2)
            }
        }
        .lineLimit(1, reservesSpace: true)
        .padding(.medium)
        .background(color.shade4)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(openTeamsButton, alignment: .bottomLeading)
    }

    private var placeOrFacultyGroup: String {
        let text = isForFacultyGroup ? event.placeLocalized : event.facultyGroup
        return text ?? ""
    }

    private var eventDescription: String {
        guard !event.isEventTransfer else { return event.typeDescription }
        return isCancelled ? L10n.eventCancelled : event.typeDescription
    }

    private var status: String? {
        if event.endDate <= currentDate {
            return nil
        } else {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            let isBeforeEvent = event.startDate > currentDate
            let date = isBeforeEvent ? event.startDate : event.endDate
            let prefix = isBeforeEvent ? "" : "\(L10n.eventFinishingIn) "
            let description = formatter.localizedString(for: date, relativeTo: currentDate)
            return prefix + description
        }
    }

    private var isEventActive: Bool {
        !event.isEventTransfer && !isCancelled
    }

    private var showTeamsButton: Bool {
        isEventInProgress && event.teamsUrl != nil
    }

    @ViewBuilder
    private var openTeamsButton: some View {
        if showTeamsButton, let teamsUrl = event.teamsUrl {
            OpenTeamsButton(url: teamsUrl)
                .padding(.medium)
        }
    }
}

#Preview {
    VStack(spacing: .large) {
        EventCardView(event: .sample, color: .blue, currentDate: .now, isEventInProgress: false, isCancelled: false)
        EventCardView(event: .eventTransfer, color: .green, currentDate: .now, isEventInProgress: false, isCancelled: false)
    }
    .padding(.large)
}
