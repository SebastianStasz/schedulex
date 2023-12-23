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
                VStack(alignment: .leading, spacing: .small) {
                    Text(event.name ?? "", style: .bodyMedium)
                        .lineLimit(2)
                        .foregroundStyle(event.facultyGroupColor.shade1)

                    VStack(alignment: .leading, spacing: .micro) {
                        Text(event.teacher ?? " ", style: .footnote)
                        Text(event.place ?? " ", style: .footnote)
                        HStack(spacing: 0) {
                            Text(event.typeDescription, style: .footnote)
                                .foregroundStyle(event.isEventTransfer ? .red : event.facultyGroupColor.shade2)
                            Spacer()
                            if let status = event.status, !event.isEventTransfer {
                                TimelineView(.periodic(from: .now, by: 1)) { _ in
                                    Text(status, style: .footnote)
                                }
                            }
                        }
                    }
                    .lineLimit(1)
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
}

#Preview {
    VStack(spacing: .large) {
        EventCardView(event: .sample)
        EventCardView(event: .eventTransfer)
    }
    .padding(.large)
}
