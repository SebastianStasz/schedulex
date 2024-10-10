//
//  UekBuilding+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 03/10/2024.
//

import Domain
import Resources

extension UekBuilding {
    var name: String {
        switch self {
        case .mainBuilding:
            return L10n.buldingMainBuilding
        case .mainLibrary:
            return L10n.buldingMainLibrary
        case .priestHouse:
            return L10n.buldingPriestHouse
        case .gardenerHouse:
            return L10n.buldingGardenerHouse
        case .watchmanHouse:
            return L10n.buldingWatchmanHouse
        case .ustronieBuilding:
            return L10n.buldingUstronie
        case .teachingAndSportsBuilding:
            return L10n.buldingTeachingAndSports
        case .pavilionA:
            return L10n.buldingPavilionA
        case .pavilionB:
            return L10n.buldingPavilionB
        case .pavilionC:
            return L10n.buldingPavilionC
        case .pavilionD:
            return L10n.buldingPavilionD
        case .pavilionE:
            return L10n.buldingPavilionE
        case .pavilionF:
            return L10n.buldingPavilionF
        case .pavilionG:
            return L10n.buldingPavilionG
        case .pavilionH:
            return L10n.buldingPavilionH
        case .rakowicka16:
            return L10n.buildingRakowicka16
        case .sienkiewicza4:
            return L10n.buildingSienkiewicza4
        case .sienkiewicza5:
            return L10n.buildingSienkiewicza5
        }
    }
}
