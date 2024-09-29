//
//  EventsListRow.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Domain
import SwiftUI
import Widgets

struct EventsListRow: View {
    let element: EventsListElement

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { timeline in
            let icon = element.makeCircleIcon(for: timeline.date)
            let isEventInProgress = icon == .doubleCircle

            HStack(alignment: .top, spacing: .medium) {
                VStack(alignment: .leading, spacing: .micro) {
                    let startTime = element.startTime ?? Date.now.formatted(style: .timeOnly)

                    Text(startTime, style: .timeMedium)
                        .foregroundStyle(.textPrimary)
                        .opacity(element.startTime == nil ? 0 : 1)

                    Text(element.endTime ?? "", style: .time)
                        .foregroundStyle(.grayShade1)
                }

                VStack(spacing: 0) {
                    Image.icon(icon)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .padding(.top, element.isFirst ? 0 : 5)
                        .padding(.bottom, 5)

                    Rectangle()
                        .frame(width: 1)

                    if element.isLast {
                        Rectangle()
                            .frame(width: 12, height: 1)
                    }
                }
                .foregroundStyle(.accentPrimary)

                switch element {
                case let .event(event, color, _, isLast, _):
                    EventCardView(event: event, color: color, currentDate: timeline.date, isEventInProgress: isEventInProgress, isCancelled: element.isCancelled, displayType: .facultyGroup)
                        .padding(.bottom, isLast ? 0 : .medium)
                case let .break(_, _, breakTimeComponents):
                    BreakCardView(breakTimeComponents: breakTimeComponents)
                        .padding(.bottom, .medium)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    VStack(spacing: .large) {
        EventsListRow(element: .event(.sample, color: .blue, isFirst: true, isLast: true, dayOff: nil))
        EventsListRow(element: .break(from: .now, to: .now, timeComponents: DateComponents(hour: 1, minute: 45)))
    }
    .padding(.medium)
}
