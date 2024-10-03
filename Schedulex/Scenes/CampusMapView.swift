//
//  CampusMapView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/10/2024.
//

import Domain
import MapKit
import SchedulexViewModel
import SwiftUI

@available(iOS 17.0, *)
struct CampusMapView: RootView {
    var store: CampusMapStore

    init(store: CampusMapStore) {
        self.store = store
    }

    @State private var position: MapCameraPosition = .camera(mapCamera)

    var rootBody: some View {
        Map(position: $position) {
            ForEach(UEKPavilions.allCases) {
                Marker($0.name, systemImage: $0.systemImage, coordinate: $0.coordinate)
                    .tint($0.color)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapPitchToggle()
        }
    }

    private static var mapCamera: MapCamera {
        let coordinate = CLLocationCoordinate2D(latitude: 50.068812, longitude: 19.954240)
        return MapCamera(centerCoordinate: coordinate, distance: 980, heading: 110, pitch: 30)
    }
}

@available(iOS 17.0, *)
final class CampusMapViewController: SwiftUIViewController<CampusMapViewModel, CampusMapView> {}

// #Preview {
//    return CampusMapView(store: CampusMapStore())
// }
