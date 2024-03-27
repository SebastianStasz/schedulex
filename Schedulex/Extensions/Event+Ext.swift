//
//  Event+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 27/03/2024.
//

import Domain
import Resources

extension Event {
    var placeDescription: String? {
        place == "link do zajęć" ? L10n.eventPlaceRemoteClasses : place
    }
}
