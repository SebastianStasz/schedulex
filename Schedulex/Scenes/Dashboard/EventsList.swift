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
            ForEach(events, id: \.self) { event in
                let isFirst = events.first == event
                let isLast = events.last == event
                
                EventRow(event: event, isFirst: isFirst, isLast: isLast)
            }
        }
    }
}

#Preview {
    EventsList(events: [.sample])
        .padding(.horizontal, .large)
}
