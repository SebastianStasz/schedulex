//
//  SchedulexApp.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Domain
import SwiftUI
import SchedulexFirebase

@main
struct SchedulexApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @StateObject private var service = FirestoreService()
    @State private var isFacultiesListPresented = false

    var body: some Scene {
        WindowGroup {
            VStack {
                if subscribedGroups.isEmpty {
                    IntroductionView()
                } else {
                    DashboardView()
                }
            }
            .sheet(isPresented: $isFacultiesListPresented) { FacultiesListView(service: service) }
            .environmentObject(service)
        }
    }
}
