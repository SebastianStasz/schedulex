//
//  UekBuilding.swift
//  Domain
//
//  Created by Sebastian Staszczyk on 03/10/2024.
//

import MapKit
import SwiftUI

public enum UekBuilding: Int, Identifiable, CaseIterable {
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
    case rakowicka16
    case sienkiewicza4
    case sienkiewicza5

    public var id: Int {
        rawValue
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
        case .rakowicka16:
            return CLLocationCoordinate2D(latitude: 50.067060, longitude: 19.952268)
        case .sienkiewicza4:
            return CLLocationCoordinate2D(latitude: 50.070356, longitude: 19.925804)
        case .sienkiewicza5:
            return CLLocationCoordinate2D(latitude: 50.070291, longitude: 19.926177)
        }
    }

    var eventPlaceCode: String? {
        switch self {
        case .mainBuilding:
            return "Bud.gł."
        case .mainLibrary:
            return "Bibl."
        case .ustronieBuilding:
            return "Paw.U"
        case .teachingAndSportsBuilding:
            return "Paw.S"
        case .pavilionA:
            return "Paw.A"
        case .pavilionB:
            return "Paw.B"
        case .pavilionC:
            return "Paw.C"
        case .pavilionD:
            return "Paw.D"
        case .pavilionE:
            return "Paw.E"
        case .pavilionF:
            return "Paw.F"
        case .pavilionG:
            return "Paw.G"
        case .pavilionH:
            return "Paw.H"
        case .rakowicka16:
            return "Rakowicka 16"
        case .sienkiewicza4:
            return "Sienk. 4"
        case .sienkiewicza5:
            return "Sienk. 5"
        default:
            return nil
        }
    }
}
