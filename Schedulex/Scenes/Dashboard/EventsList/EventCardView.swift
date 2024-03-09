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
    let currentDate: Date
    let isEventInProgress: Bool

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
                            .opacity(showTeamsButton ? 0 : 1)
                    }

                    HStack(spacing: 0) {
                        Text(event.typeDescription, style: .footnote)
                            .foregroundStyle(event.isEventTransfer ? .red : event.facultyGroupColor.shade2)
                            .opacity(showTeamsButton ? 0 : 1)

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
        .overlay(teamsButton.padding(.medium), alignment: .bottomLeading)
    }

    private var status: String? {
        guard let startDate = event.startDate, let endDate = event.endDate else { return nil }
        if endDate <= currentDate {
            return nil
        } else {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            let isBeforeEvent = startDate > currentDate
            let date = isBeforeEvent ? startDate : endDate
            let prefix = isBeforeEvent ? "" : "\(L10n.eventFinishingIn) "
            let description = formatter.localizedString(for: date, relativeTo: currentDate)
            return prefix + description
        }
    }

    private var showTeamsButton: Bool {
        isEventInProgress && event.teamsUrl != nil
    }

    @ViewBuilder
    private var teamsButton: some View {
        if showTeamsButton, let teamsUrl = event.teamsUrl {
            HStack(spacing: .small) {
                Image.teamsLogo
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)

                Text(L10n.dashboardOpenTeams, style: .footnote)
                    .foregroundStyle(Color.white)
            }
            .padding(.small)
            .background(Color.black.opacity(0.5))
            .cornerRadius(.medium)
            .onTapGesture { openURL(teamsUrl) }
        }
    }
}

#Preview {
    VStack(spacing: .large) {
        EventCardView(event: .sample, currentDate: .now, isEventInProgress: false)
        EventCardView(event: .eventTransfer, currentDate: .now, isEventInProgress: false)
    }
    .padding(.large)
}
