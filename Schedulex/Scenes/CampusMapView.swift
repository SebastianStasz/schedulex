//
//  CampusMapView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/10/2024.
//

import Domain
import MapKit
import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

@available(iOS 17.0, *)
struct CampusMapView: RootView {
    var store: CampusMapStore

    init(store: CampusMapStore) {
        self.store = store
    }

    @State private var position: MapCameraPosition = .camera(mapCamera)
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedBuilding: UekBuilding?

    var rootBody: some View {
        Map(position: $position, selection: $selectedBuilding) {
            ForEach(UekBuilding.allCases, content: makeMarker)
        }
        .mapStyle(.standard(pointsOfInterest: .including([.cafe, .restaurant, .parking])))
        .mapControls {
            MapPitchToggle()
        }
        .onMapCameraChange { visibleRegion = $0.region }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 0) {
                Spacer()
                ResetExpandableButton(title: L10n.campusMapReset, isDefaultValueSelected: !isRegionDifferent, action: {
                    position = .camera(Self.mapCamera)
                })
            }
            .padding(.top, .small)
            .padding(.horizontal, .large)
            .background(.thinMaterial)
        }
    }

    private func makeMarker(for building: UekBuilding) -> some MapContent {
        Marker(building.name, systemImage: building.systemImage, coordinate: building.coordinate)
            .tint(building.color)
            .tag(building)
    }

    private var isRegionDifferent: Bool {
        guard let currentLatitude = visibleRegion?.center.latitude,
              let currentLongitude = visibleRegion?.center.longitude
        else { return true }

        let tolerance: CLLocationDegrees = 0.002
        return abs(currentLatitude - Self.defaultCoordinate.latitude) > tolerance ||
            abs(currentLongitude - Self.defaultCoordinate.longitude) > tolerance
    }

    private static var mapCamera: MapCamera {
        MapCamera(centerCoordinate: defaultCoordinate, distance: 980, heading: 110, pitch: 30)
    }

    private static var defaultCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 50.068638, longitude: 19.954687)
    }
}

@available(iOS 17.0, *)
final class CampusMapViewController: SwiftUIViewController<CampusMapViewModel, CampusMapView> {}
