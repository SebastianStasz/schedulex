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
    var building: UekBuilding?

    func makeStore(context: Context) -> CampusMapStore {
        let store = CampusMapStore(position: .camera(makeMapCamera()))
        store.selectedBuilding = building

        store.viewDidAppear
            .sink(on: store) {
                guard let selectedBuilding = $0.selectedBuilding else { return }
                $0.position = .camera(makeMapCamera(coordinate: selectedBuilding.coordinate))
            }

        store.resetPosition
            .sink(on: store) {
                $0.position = .camera(makeMapCamera())
            }

        store.$visibleRegion
            .compactMap { $0 }
            .map { !checkIsRegionDifferent(region: $0) }
            .assign(to: &store.$isDefaultRegionVisible)

        return store
    }

    private func checkIsRegionDifferent(region: MKCoordinateRegion) -> Bool {
        abs(region.center.latitude - defaultCoordinate.latitude) > 0.001 ||
            abs(region.center.longitude - defaultCoordinate.longitude) > 0.002
    }

    private func makeMapCamera(coordinate: CLLocationCoordinate2D? = nil) -> MapCamera {
        MapCamera(centerCoordinate: coordinate ?? defaultCoordinate, distance: 980, heading: 110, pitch: 30)
    }

    private var defaultCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 50.068638, longitude: 19.954687)
    }
}
