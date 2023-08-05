//
//  TabBarView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "house") }

            NavigationStack {
                SchoolView()
                    .navigationDestination(for: Faculty.self) {
                        FacultyGroupsList(faculty: $0)
                    }
                    .navigationDestination(for: FacultyGroup.self) {
                        FacultyGroupView(facultyGroup: $0)
                    }
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
