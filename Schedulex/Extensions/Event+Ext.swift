//
//  Event+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 27/03/2024.
//

import Domain
import Resources

extension Event {
    var nameLocalized: String {
        name ?? L10n.eventUnknownTitle
    }

    var placeLocalized: String? {
        isRemoteClass ? L10n.eventPlaceRemoteClasses : place
    }

    func toFacultyGroupEvent(facultyGroup: FacultyGroupDetails) -> FacultyGroupEvent {
        FacultyGroupEvent(facultyGroupName: facultyGroup.name, color: facultyGroup.color, event: self)
    }
}
