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
    @State private var selectedEvent: FacultyGroupEvent?
    let events: [FacultyGroupEvent]
    let dayOff: DayOff?
    let openMapWithBuilding: (UekBuilding) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(events.indices, id: \.self) { id in
                let event = events[id]
                let nextEvent = events[safe: id + 1]
                let isFirst = events.first == event
                let isLast = events.last == event

                EventsListRow(element: .event(event.event, color: event.color, isFirst: isFirst, isLast: isLast, dayOff: dayOff))
                    .onTapGesture { selectedEvent = event }

                if let nextEvent,
                   let breakTimeComponents = getBreakTimeComponents(startDate: event.endDate, endDate: nextEvent.startDate)
                {
                    EventsListRow(element: .break(from: event.endDate, to: nextEvent.startDate, timeComponents: breakTimeComponents))
                }
            }
        }
        .sheet(item: $selectedEvent) { EventDetailsView(event: $0.event, displayType: .facultyGroup, openMapWithBuilding: openCampusMap) }
    }

    private func getBreakTimeComponents(startDate: Date, endDate: Date) -> DateComponents? {
        guard let minutesOfBreak = Calendar.current.dateComponents([.minute], from: startDate, to: endDate).minute,
              minutesOfBreak > 15
        else { return nil }
        return Calendar.current.dateComponents([.hour, .minute], from: startDate, to: endDate)
    }

    private func openCampusMap(with building: UekBuilding) {
        selectedEvent = nil
        openMapWithBuilding(building)
    }
}

#Preview {
    EventsList(events: [.sample], dayOff: nil, openMapWithBuilding: { _ in })
        .padding(.horizontal, .large)
}
