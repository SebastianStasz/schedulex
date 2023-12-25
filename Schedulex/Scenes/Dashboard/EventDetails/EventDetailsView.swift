//
//  EventDetailsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/12/2023.
//

import Domain
import SwiftUI
import Widgets
import Resources

struct EventDetailsView: View {
    @Environment(\.openURL) var openURL

    let event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            VStack(alignment: .leading, spacing: .micro) {
                Text(subtitle, style: .body)
                    .foregroundStyle(.grayShade1)

                Text(event.name ?? "", style: .titleSmall)
                    .foregroundStyle(.textPrimary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: .medium) {
                line(title: event.teacher ?? "", icon: .person)
                line(title: event.place ?? "", icon: .building)
                line(title: event.type ?? "", icon: .paperPlane)
            }

            VStack(spacing: .medium) {
                if let teamsUrl = event.teamsUrl {
                    LinkCard(title: L10n.eventDetailsLinkToClass, subtitle: teamsUrl.description, image: .teamsLogo) { openURL(teamsUrl) }
                }
                if let teacherProfileUrl = event.teacherProfileUrl {
                    LinkCard(title: L10n.eventDetailsBusinessCard, subtitle: teacherProfileUrl.description, icon: .contactCard) { openURL(teacherProfileUrl) }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, .large)
        .padding(.top, 40)
        .background(.backgroundSecondary)
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium])
    }

    private func line(title: String, icon: Icon) -> some View {
        HStack(spacing: .medium) {
            Image.icon(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .foregroundStyle(.accentPrimary)

            Text(title.capitalizingFirstLetter(), style: .footnoteBig)
        }
    }

    private var subtitle: String {
        guard let startDate = event.startDate, let endDate = event.endDate else { return "" }
        let date = startDate.formatted(style: .dateLong)
        let startTime = startDate.formatted(style: .timeOnly)
        let endTime = endDate.formatted(style: .timeOnly)
        return "\(date)  |  \(startTime) - \(endTime)"
    }
}

#Preview {
    Text("Some content")
        .sheet(isPresented: .constant(true)) {
            EventDetailsView(event: .sample)
        }
}
