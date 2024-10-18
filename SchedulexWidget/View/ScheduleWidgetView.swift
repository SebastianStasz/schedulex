//
//  ScheduleWidgetView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 10/10/2024.
//

import Domain
import Resources
import SwiftUI
import WidgetKit
import Widgets

struct ScheduleWidgetView: View {
    @Environment(\.colorScheme) private var colorScheme
    let entry: ScheduleWidgetProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            VStack(alignment: .leading, spacing: 0) {
                Text(L10n.today, style: .body)

                Text(todayNote)
                    .font(.caption)
                    .foregroundStyle(.grayShade1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(entry.events.prefix(2)) {
                        EventWidgetCardView(event: $0)
                    }
                }

                if entry.events.count <= 1, let nextDateSchedule = entry.nextDaySchedule {
                    Spacer()

                    VStack(alignment: .leading, spacing: 4) {
                        nextDayWithEventsHeader(date: nextDateSchedule.date)

                        if entry.events.isEmpty {
                            if let nextDayScheduleFirstEvent = nextDateSchedule.events.first {
                                EventWidgetCardView(event: nextDayScheduleFirstEvent)
                            }
                            if nextDateSchedule.numberOfEvents > 1 {
                                let message = nextDayEventsIndicatorMessage(nextDaySchedule: nextDateSchedule)
                                numberOfEventsIndicator(message: message)
                            }
                        } else {
                            let message = eventsNumberMessage(count: nextDateSchedule.numberOfEvents)
                            numberOfEventsIndicator(message: message)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .widgetContainer()
    }

    private func nextDayWithEventsHeader(date: Date) -> some View {
        Text(date.isInTomorrow ? L10n.tomorrow : date.formatted(style: .dateLong))
            .font(.caption)
            .textCase(.uppercase)
            .fontWeight(.semibold)
            .foregroundStyle(.textSecondary)
    }

    private func numberOfEventsIndicator(message: String) -> some View {
        HStack(spacing: .micro) {
            RoundedRectangle(cornerRadius: 100)
                .fill(entry.events.first?.primaryColor(for: colorScheme) ?? entry.nextDaySchedule?.events.first?.primaryColor(for: colorScheme) ?? .accentPrimary)
                .frame(width: 3, height: 16)
            Text(message, style: .footnote)
        }
    }

    private var todayNote: String {
        guard !entry.events.isEmpty else {
            return L10n.widgetNoMoreEvents
        }
        let numberOfEvents = entry.events.count
        return "\(eventsNumberMessage(count: numberOfEvents)) left"
    }

    private func nextDayEventsIndicatorMessage(nextDaySchedule: NextDaySchedule) -> String {
        let numberOfEvents = nextDaySchedule.numberOfEvents - 1
        let eventMessage = numberOfEvents == 1 ? "event" : "events"
        return "\(numberOfEvents) more \(eventMessage)"
    }

    private func eventsNumberMessage(count: Int) -> String {
        let eventMessage = count == 1 ? "event" : "events"
        return "\(count) \(eventMessage)"
    }
}

private extension View {
    @ViewBuilder
    func widgetContainer() -> some View {
        if #available(iOS 17, *) {
            containerBackground(.fill.tertiary, for: .widget)
        } else {
            padding(.large).background(.grayShade2)
        }
    }
}
