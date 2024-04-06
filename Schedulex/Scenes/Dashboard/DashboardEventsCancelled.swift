//
//  DashboardEventsCancelled.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 06/04/2024.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct DashboardEventsCancelled: View {
    let dayOff: DayOff

    var body: some View {
        Text(message, style: .bodyMedium)
            .foregroundStyle(.grayShade1)
            .padding(.vertical, .xlarge)
    }

    private var message: String {
        eventsCancelledBetweenHoursMessage ?? L10n.allEventsCancelled
    }

    private var eventsCancelledBetweenHoursMessage: String? {
        guard let startTime = dayOff.startTime, let endTime = dayOff.endTime else {
            return nil
        }
        let startTimeFormatted = startTime.formatted(style: .timeOnly)
        let endTimeFormatted = endTime.formatted(style: .timeOnly)
        return L10n.eventsCancelledBetweenHours + " \(startTimeFormatted) - \(endTimeFormatted)"
    }
}

#Preview {
    DashboardEventsCancelled(dayOff: DayOff(date: .now, startTime: nil, endTime: nil))
}
