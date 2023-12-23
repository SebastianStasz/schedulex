//
//  EventRow.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Domain
import SwiftUI
import Widgets

enum EventsListElement {
    case event(Event, isFirst: Bool, isLast: Bool)
    case `break`(DateComponents)

    var isFirst: Bool {
        guard case let .event(_, isFirst, _) = self else { return false }
        return isFirst
    }

    var isLast: Bool {
        guard case let .event(_, _, isLast) = self else { return false }
        return isLast
    }

    var startTime: String? {
        guard case let .event(event, _, _) = self else { return nil }
        return event.startDate?.formatted(style: .timeOnly)
    }

    var endTime: String? {
        guard case let .event(event, _, _) = self else { return nil }
        return event.endDate?.formatted(style: .timeOnly)
    }

    var circleIcon: Icon {
        guard case let .event(event, _, _) = self else { return .circle }
        return event.status == nil ? .circleFill : .circle
    }
}

struct EventRow: View {
    let element: EventsListElement

    var body: some View {
        HStack(alignment: .top, spacing: .medium) {
            VStack(alignment: .leading, spacing: .micro) {
                let startTime = element.startTime ?? Date.now.formatted(style: .timeOnly)

                Text(startTime, style: .timeMedium)
                    .foregroundStyle(.textPrimary)
                    .opacity(element.startTime == nil ? 0 : 1)

                Text(element.endTime ?? "", style: .time)
                    .foregroundStyle(.textSecondary)
            }

            VStack(spacing: 0) {
                Image.icon(element.circleIcon)
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
            case let .event(event, _, isLast):
                EventCardView(event: event)
                    .padding(.bottom, isLast ? 0 : .medium)
            case let .break(breakTimeComponents):
                Text(breakTimeDescription(from: breakTimeComponents), style: .footnote)
                    .padding(.large)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.textPrimary)
                    .background(Color.accentPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, .medium)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private func breakTimeDescription(from components: DateComponents) -> String {
        guard let time = Calendar.current.date(from: components),
              let hour = components.hour
        else { return "Przerwa" }
        let suffix = hour == 0 ? "minut" : "g."
        return "Przerwa \(time.formatted(style: .timeBetween)) \(suffix)"
    }
}

#Preview {
    VStack(spacing: .large) {
        EventRow(element: .event(.sample, isFirst: true, isLast: true))
        EventRow(element: .break(DateComponents(hour: 1, minute: 45)))
    }
    .padding(.medium)
}
