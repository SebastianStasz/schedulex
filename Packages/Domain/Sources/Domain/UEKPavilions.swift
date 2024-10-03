//
//  UEKPavilions.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 03/10/2024.
//

import MapKit
import Resources
import SwiftUI

public enum UEKPavilions: Int, Identifiable, CaseIterable {
    case mainBuilding
    case mainLibrary
    case priestHouse
    case gardenerHouse
    case watchmanHouse
    case ustronieBuilding
    case teachingAndSportsBuilding
    case pavilionA
    case pavilionB
    case pavilionC
    case pavilionD
    case pavilionE
    case pavilionF
    case pavilionG
    case pavilionH

    public var id: Int {
        rawValue
    }

    public var name: String {
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
        }
    }

    public var systemImage: String {
        switch self {
        case .mainBuilding:
            return "house"
        case .mainLibrary:
            return "book"
        case .priestHouse:
            return "cross"
        case .gardenerHouse:
            return "leaf"
        case .watchmanHouse:
            return "eye"
        case .ustronieBuilding:
            return "house.lodge"
        case .teachingAndSportsBuilding:
            return "sportscourt"
        default:
            return "building.2.crop.circle"
        }
    }

    public var color: Color {
        switch self {
        case .mainBuilding:
            return .red
        case .mainLibrary:
            return .blue
        case .priestHouse:
            return .purple
        case .gardenerHouse:
            return .green
        case .watchmanHouse:
            return .gray
        case .ustronieBuilding:
            return .green
        case .teachingAndSportsBuilding:
            return .teal
        default:
            return .orange
        }
    }

    public var coordinate: CLLocationCoordinate2D {
        switch self {
        case .mainBuilding:
            return CLLocationCoordinate2D(latitude: 50.068510, longitude: 19.953841)
        case .mainLibrary:
            return CLLocationCoordinate2D(latitude: 50.068592, longitude: 19.955989)
        case .priestHouse:
            return CLLocationCoordinate2D(latitude: 50.069178, longitude: 19.954058)
        case .gardenerHouse:
            return CLLocationCoordinate2D(latitude: 50.069093, longitude: 19.953490)
        case .watchmanHouse:
            return CLLocationCoordinate2D(latitude: 50.068317, longitude: 19.952929)
        case .ustronieBuilding:
            return CLLocationCoordinate2D(latitude: 50.068002, longitude: 19.955518)
        case .teachingAndSportsBuilding:
            return CLLocationCoordinate2D(latitude: 50.067945, longitude: 19.956387)
        case .pavilionA:
            return CLLocationCoordinate2D(latitude: 50.069175, longitude: 19.954742)
        case .pavilionB:
            return CLLocationCoordinate2D(latitude: 50.068947, longitude: 19.955509)
        case .pavilionC:
            return CLLocationCoordinate2D(latitude: 50.069204, longitude: 19.955226)
        case .pavilionD:
            return CLLocationCoordinate2D(latitude: 50.069398, longitude: 19.954337)
        case .pavilionE:
            return CLLocationCoordinate2D(latitude: 50.069048, longitude: 19.955878)
        case .pavilionF:
            return CLLocationCoordinate2D(latitude: 50.068423, longitude: 19.956682)
        case .pavilionG:
            return CLLocationCoordinate2D(latitude: 50.069522, longitude: 19.953919)
        case .pavilionH:
            return CLLocationCoordinate2D(latitude: 50.069172, longitude: 19.957654)
        }
    }
}
