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
        TimelineView(.periodic(from: .now, by: 1)) { _ in
            VStack(spacing: 0) {
                ForEach(events.indices, id: \.self) { id in
                    let event = events[id]
                    let nextEvent = events[safe: id + 1]
                    let isFirst = events.first == event
                    let isLast = events.last == event
                    
                    EventsListRow(element: .event(event, isFirst: isFirst, isLast: isLast))

                    if let nextEvent,
                       let startDate = event.endDate,
                       let endDate = nextEvent.startDate,
                       let breakTimeComponents = getBreakTimeComponents(startDate: startDate, endDate: endDate) {
                        EventsListRow(element: .break(from: startDate, to: endDate, timeComponents: breakTimeComponents))
                    }
                }
            }
        }
    }

    private func getBreakTimeComponents(startDate: Date, endDate: Date) -> DateComponents? {
        guard let minutesOfBreak = Calendar.current.dateComponents([.minute], from: startDate, to: endDate).minute,
              minutesOfBreak > 15
        else { return nil }
        return Calendar.current.dateComponents([.hour, .minute], from: startDate, to: endDate)
    }
}

#Preview {
    EventsList(events: [.sample])
        .padding(.horizontal, .large)
}
