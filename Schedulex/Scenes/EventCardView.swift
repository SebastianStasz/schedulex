//
//  EventCardView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 20/09/2023.
//

import Domain
import SwiftUI
import Widgets

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(alignment: .top, spacing: .medium) {
                VStack(alignment: .leading, spacing: .micro) {
                    Text(event.startDate?.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)).minute(.twoDigits)) ?? "")
                    Text(event.endDate?.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)).minute(.twoDigits)) ?? "")
                }
                .foregroundStyle(.blueShade1)
                .font(.note)

                VStack(alignment: .leading, spacing: .micro) {
                    Text(event.name ?? "", style: .body)
                        .foregroundStyle(.blueShade1)

                    Text(event.place ?? "", style: .note)
                        .foregroundStyle(.blueShade2)
                    
                    Text(event.type ?? "", style: .note)
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
}

#Preview {
    EventCardView(event: .sample)
        .padding()
}
