//
//  ScheduleWidgetView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 10/10/2024.
//

import Domain
import SwiftUI
import WidgetKit
import Widgets

@available(iOS 17.0, *)
struct ScheduleWidgetView: View {
    let entry: ScheduleWidgetProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            headerView

            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(entry.events.prefix(2)) {
                        EventWidgetCardView(event: $0)
                    }
                }

                if entry.events.count <= 1, let nextDaySchedule = entry.nextDaySchedule {
                    Spacer()

                    VStack(alignment: .leading, spacing: 4) {
                        Text(nextDateDescription(nextDaySchedule.date))
                            .font(.caption)
                            .textCase(.uppercase)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textSecondary)

                        if entry.events.isEmpty {
                            if let nextDayScheduleFirstEvent = nextDaySchedule.events.first {
                                EventWidgetCardView(event: nextDayScheduleFirstEvent)
                            }
                            if nextDaySchedule.numberOfEvents > 1 {
                                let message = nextDayEventsIndicatorMessage(nextDaySchedule: nextDaySchedule)
                                numberOfEventsIndicator(message: message)
                            }
                        } else {
                            let message = eventsNumberMessage(count: nextDaySchedule.numberOfEvents)
                            numberOfEventsIndicator(message: message)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Today", style: .body)

            Text(todayNote)
                .font(.caption)
                .foregroundStyle(.grayShade1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func numberOfEventsIndicator(message: String) -> some View {
        HStack(spacing: .micro) {
            RoundedRectangle(cornerRadius: 100)
                .fill(.accentPrimary)
                .frame(width: 3, height: 16)
            Text(message, style: .footnote)
        }
    }

    private var todayNote: String {
        guard !entry.events.isEmpty else {
            return "No more events"
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

    private func nextDateDescription(_ date: Date) -> String {
        guard let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: .now) else {
            return date.formatted(style: .dateLong)
        }
        return date.isSameDay(as: tomorrowDate) ? "Tomorrow" : date.formatted(style: .dateLong)
    }
}
