//
//  CampusMapViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/10/2024.
//

import Domain
import MapKit
import SchedulexCore
import SchedulexViewModel
import SwiftUI

@available(iOS 17.0, *)
final class CampusMapStore: RootStore {
    @Published var position: MapCameraPosition
    @Published var visibleRegion: MKCoordinateRegion?
    @Published var selectedBuilding: UekBuilding?
    @Published fileprivate(set) var isDefaultRegionVisible = true

    let resetPosition = DriverSubject<Void>()

    init(position: MapCameraPosition) {
        self.position = position
    }
}

@available(iOS 17.0, *)
struct CampusMapViewModel: ViewModel {
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> CampusMapStore {
        let store = CampusMapStore(position: .camera(mapCamera))

        store.resetPosition
            .sink(on: store) {
                $0.position = .camera(mapCamera)
            }

        store.$visibleRegion
            .compactMap { $0 }
            .map { !checkIsRegionDifferent(region: $0) }
            .assign(to: &store.$isDefaultRegionVisible)

        return store
    }

    private func checkIsRegionDifferent(region: MKCoordinateRegion) -> Bool {
        let tolerance: CLLocationDegrees = 0.002
        return abs(region.center.latitude - defaultCoordinate.latitude) > tolerance ||
            abs(region.center.longitude - defaultCoordinate.longitude) > tolerance
    }

    private var mapCamera: MapCamera {
        MapCamera(centerCoordinate: defaultCoordinate, distance: 980, heading: 110, pitch: 30)
    }

    private var defaultCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 50.068638, longitude: 19.954687)
    }
}
