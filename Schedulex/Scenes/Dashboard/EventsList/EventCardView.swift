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
                Text(event.name ?? "", style: .bodyMedium)
                    .foregroundStyle(event.facultyGroupColor.shade1)

                VStack(alignment: .leading, spacing: .micro) {
                    Text(event.teacher ?? " ", style: .footnote)

                    if !event.isEventTransfer {
                        Text(event.place ?? " ", style: .footnote)
                    }

                    HStack(spacing: 0) {
                        Text(event.typeDescription, style: .footnote)
                            .foregroundStyle(event.isEventTransfer ? .red : event.facultyGroupColor.shade2)

                        Spacer()

                        if let status = event.status, !event.isEventTransfer {
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
}

#Preview {
    VStack(spacing: .large) {
        EventCardView(event: .sample)
        EventCardView(event: .eventTransfer)
    }
    .padding(.large)
}
