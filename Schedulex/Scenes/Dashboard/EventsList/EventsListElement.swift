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
    case event(Event, isFirst: Bool, isLast: Bool, dayOff: DayOff?)
    case `break`(from: Date, to: Date, timeComponents: DateComponents)

    var isFirst: Bool {
        guard case let .event(_, isFirst, _, _) = self else { return false }
        return isFirst
    }

    var isLast: Bool {
        guard case let .event(_, _, isLast, _) = self else { return false }
        return isLast
    }

    var startTime: String? {
        guard case let .event(event, _, _, _) = self else { return nil }
        return event.startDate?.formatted(style: .timeOnly)
    }

    var endTime: String? {
        guard case let .event(event, _, _, _) = self else { return nil }
        return event.endDate?.formatted(style: .timeOnly)
    }

    var isCancelled: Bool {
        guard case let .event(event, _, _, dayOff) = self else { return false }
        guard let startDate = event.startDate, let endDate = event.endDate, let dayOff else {
            return false
        }
        guard let startTime = dayOff.startTime, let endTime = dayOff.endTime else {
            return true
        }
        let startTime2 = Calendar.current.date(byAdding: .second, value: -1, to: startTime)!
        let endTime2 = Calendar.current.date(byAdding: .second, value: 1, to: endTime)!
        return startDate > startTime2 && endDate < endTime2
    }

    func makeCircleIcon(for date: Date) -> Icon {
        switch self {
        case let .event(event, _, _, _):
            guard !isCancelled else { return .freeHoursCircleFill }
            guard let endDate = event.endDate, endDate > date else { return .circleFill }
            return event.startDate! > date ? .circle : .doubleCircle
        case let .break(startDate, endDate, _):
            guard startDate < date else { return .circle }
            return endDate > date ? .doubleCircle : .circleFill
        }
    }
}

extension Date {
    func isBetweenOrEqual(_ date1: Date, and date2: Date) -> Bool {
        self == date1 || (min(date1, date2)...max(date1, date2)).contains(self)
    }
}
