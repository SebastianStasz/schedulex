//
//  Icon.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

public enum Icon: String, Identifiable, CaseIterable {
    case settings
    case closeButton
    case delete
    case info
    case circle
    case recordCircle
    case doubleCircle
    case circleFill
    case checkmark
    case chevronRight
    case plusCircle
    case person
    case pavilionsList
    case teachersList
    case building
    case paperPlane
    case contactCard
    case menu
    case edit
    case more
    case freeHoursCircleFill
    case calendar
    case chevronForwardCircle
    case map

    public var id: String {
        rawValue
    }

    var name: String {
        switch self {
        case .settings:
            return "gearshape.fill"
        case .closeButton:
            return "xmark"
        case .delete:
            return "trash.fill"
        case .info:
            return "info.circle"
        case .circle:
            return "circle"
        case .recordCircle:
            return "record.circle"
        case .doubleCircle:
            return "circle.circle"
        case .circleFill:
            return "circle.fill"
        case .checkmark:
            return "checkmark.circle.fill"
        case .chevronRight:
            return "chevron.right"
        case .plusCircle:
            return "plus.circle"
        case .person:
            return "person.fill"
        case .pavilionsList:
            return "building.2.fill"
        case .teachersList:
            return "person.2.fill"
        case .building:
            return "building.fill"
        case .paperPlane:
            return "paperplane.fill"
        case .contactCard:
            return "person.text.rectangle.fill"
        case .menu:
            return "ellipsis"
        case .edit:
            return "slider.horizontal.3"
        case .freeHoursCircleFill:
            return "r.circle.fill"
        case .calendar:
            return "calendar"
        case .more:
            return "ellipsis.circle"
        case .chevronForwardCircle:
            return "chevron.forward.circle"
        case .map:
            return "map.fill"
        }
    }
}
