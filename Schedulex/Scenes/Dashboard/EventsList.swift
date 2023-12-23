//
//  EventsList.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Domain
import SwiftUI
import Widgets

struct EventsList: View {
    let events: [Event]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(events.indices, id: \.self) { id in
                let event = events[id]
                let nextEvent = events[safe: id + 1]
                let isFirst = events.first == event
                let isLast = events.last == event

                EventRow(element: .event(event, isFirst: isFirst, isLast: isLast))

                if let nextEvent, let breakTimeComponents = getBreakTimeComponents(after: event, andBefore: nextEvent) {
                    EventRow(element: .break(breakTimeComponents))
                }
            }
        }
    }

    private func getBreakTimeComponents(after event: Event, andBefore nextEvent: Event) -> DateComponents? {
        guard let endDate = event.endDate,
              let startDate = nextEvent.startDate,
              let minutesOfBreak = Calendar.current.dateComponents([.minute], from: endDate, to: startDate).minute,
              minutesOfBreak > 15
        else { return nil }
        return Calendar.current.dateComponents([.hour, .minute], from: endDate, to: startDate)
    }
}

#Preview {
    EventsList(events: [.sample])
        .padding(.horizontal, .large)
}
