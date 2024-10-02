//
//  CampusMapView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/10/2024.
//

import SwiftUI
import SchedulexViewModel

struct CampusMapView: RootView {
    var store: CampusMapStore

    var rootBody: some View {
        Color.white
            .overlay(alignment: .bottom, content: mapView)
            .clipped()
    }

    private func mapView() -> some View {
        Image.camusMap
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

final class CampusMapViewController: SwiftUIViewController<CampusMapViewModel, CampusMapView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UEK Campus"
    }
}

#Preview {
    CampusMapView(store: CampusMapStore())
}
