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
    @ObservedObject var store: CampusMapStore

    init(store: CampusMapStore) {
        self.store = store
    }

    var rootBody: some View {
        Map(position: $store.position, selection: $store.selectedBuilding) {
            ForEach(UekBuilding.allCases, content: makeMarker)
        }
        .mapStyle(.standard(pointsOfInterest: .including([.cafe, .restaurant, .brewery, .bakery, .winery, .parking])))
        .mapControls {
            MapPitchToggle()
        }
        .onMapCameraChange { store.visibleRegion = $0.region }
        .safeAreaInset(edge: .bottom, content: makeBottomMenu)
    }

    private func makeMarker(for building: UekBuilding) -> some MapContent {
        Marker(building.name, systemImage: building.systemImage, coordinate: building.coordinate)
            .tint(building.color)
            .tag(building)
    }

    private func makeBottomMenu() -> some View {
        HStack(spacing: 0) {
            Spacer()
            ResetExpandableButton(title: L10n.campusMapReset, isDefaultValueSelected: store.isDefaultRegionVisible) {
                store.resetPosition.send()
            }
        }
        .padding(.top, .small)
        .padding(.horizontal, .large)
        .background(.thinMaterial)
    }
}

@available(iOS 17.0, *)
final class CampusMapViewController: SwiftUIViewController<CampusMapViewModel, CampusMapView> {}
