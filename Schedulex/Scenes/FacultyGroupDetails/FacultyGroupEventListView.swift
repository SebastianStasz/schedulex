//
//  FacultyGroupEventListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import SwiftUI
import Widgets

struct FacultyGroupEventListView: View {
    let title: String
    let color: FacultyGroupColor
    let events: [Event]

    var body: some View {
        SectionedList(listSections ?? [], separatorHeight: .medium) { _, event in
            EventCardView(event: event, color: color, currentDate: .now, isEventInProgress: false, isCancelled: false)
        }
        .navigationTitle(title)
        .baseListStyle()
    }

    private var listSections: [ListSection<Event>]? {
        events
            .filter { $0.startDate != nil }
            .reduce(into: [ListSection<Event>]()) { result, event in
                let date = event.startDateWithoutTime!.formatted(style: .dateLong)
                if let sectionIndex = result.firstIndex(where: { $0.title == date }) {
                    let items = result[sectionIndex].items
                    result.remove(at: sectionIndex)
                    result.append(ListSection(title: date, items: items + [event]))
                } else {
                    result.append(ListSection(title: date, items: [event]))
                }
            }
    }
}

#Preview {
    FacultyGroupEventListView(title: "Title", color: .blue, events: [])
}
