//
//  EventDisplayType.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 29/09/2024.
//

import Domain
import Resources
import Foundation

enum EventDisplayType {
    case teacher
    case classroom
    case facultyGroup

    func getFirstRowText(from event: Event) -> String? {
        switch self {
        case .teacher:
            return event.placeLocalized
        case .classroom, .facultyGroup:
            return event.teacher
        }
    }

    func getSecondRowText(from event: Event) -> String? {
        switch self {
        case .facultyGroup:
            return event.placeLocalized
        case .teacher, .classroom:
            return event.facultyGroup
        }
    }

    func getThirdRowText(from event: Event, isCancelled: Bool) -> String {
        guard !event.isEventTransfer else { return event.typeDescription }
        return isCancelled ? L10n.eventCancelled : event.typeDescription
    }
}
