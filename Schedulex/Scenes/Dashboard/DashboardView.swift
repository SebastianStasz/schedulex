//
//  DashboardView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import SwiftUI

struct DashboardView: RootView {
    @ObservedObject var store: DashboardStore

    var rootBody: some View {
        Text("Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(store: DashboardStore())
    }
}
