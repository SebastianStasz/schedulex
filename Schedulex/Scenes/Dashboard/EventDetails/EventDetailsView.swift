//
//  EventDetailsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/12/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct EventDetailsView: View {
    @Environment(\.openURL) private var openURL

    let event: Event
    let displayType: EventDisplayType
    let openMapWithBuilding: (UekBuilding) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            VStack(alignment: .leading, spacing: .micro) {
                Text(subtitle, style: .body)
                    .foregroundStyle(.grayShade1)

                Text(event.nameLocalized, style: .titleSmall)
                    .foregroundStyle(.textPrimary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: .medium) {
                line(title: displayType.getFirstRowText(from: event) ?? "", icon: .person)
                line(title: displayType.getSecondRowText(from: event) ?? "", icon: .building)
                line(title: displayType.getThirdRowText(from: event, isCancelled: false), icon: .paperPlane)
            }

            VStack(spacing: .medium) {
                if let teamsUrl = event.teamsUrl {
                    LinkCard(title: L10n.eventDetailsLinkToClass, subtitle: teamsUrl.description, image: .teamsLogo) { openURL(teamsUrl) }
                }
                if let building = event.building {
                    LinkCard(title: L10n.eventDetailsSeeOnMap, subtitle: building.name, icon: .map) { openMapWithBuilding(building) }
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
        .presentationDetents([UIDevice.current.hasNotch ? .medium : .height(440)])
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
        let date = event.startDate.formatted(style: .dateLong)
        let startTime = event.startDate.formatted(style: .timeOnly)
        let endTime = event.endDate.formatted(style: .timeOnly)
        return "\(date)  |  \(startTime) - \(endTime)"
    }
}

#Preview {
    Text("Some content")
        .sheet(isPresented: .constant(true)) {
            EventDetailsView(event: .sample, displayType: .facultyGroup, openMapWithBuilding: { _ in })
        }
}
