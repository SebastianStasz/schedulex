//
//  EventsListElement.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Domain
import Foundation
import Widgets

enum EventsListElement {
    case event(Event, isFirst: Bool, isLast: Bool)
    case `break`(from: Date, to: Date, timeComponents: DateComponents)

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
        switch self {
        case let .event(event, _, _):
            guard event.status != nil else { return .circleFill }
            return event.startDate! > .now ? .circle : .doubleCircle
        case let .break(startDate, endDate, _):
            guard startDate < .now else { return .circle }
            return endDate > .now ? .doubleCircle : .circleFill
        }
    }
}
