//
//  TabBarView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "house") }

            NavigationStack {
                SchoolView()
            }
            .tabItem { Label("UEK", systemImage: "graduationcap") }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
