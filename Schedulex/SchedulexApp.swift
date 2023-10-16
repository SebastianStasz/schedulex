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
    @AppStorage("didSetColorsForSubscribedGroups") private var didSetColorsForSubscribedGroups = false
    @StateObject private var service = FirestoreService()
    @State private var isFacultiesListPresented = false

    var body: some Scene {
        WindowGroup {
            VStack {
                if subscribedGroups.isEmpty {
                    IntroductionView()
                } else {
                    DashboardView(isFacultiesListPresented: $isFacultiesListPresented)
                }
            }
            .sheet(isPresented: $isFacultiesListPresented) { FacultiesListView(service: service) }
            .environmentObject(service)
            .onAppear { setColorsForSubscribedGroupsIfNeeded() }
        }
    }

    private func setColorsForSubscribedGroupsIfNeeded() {
        guard !subscribedGroups.isEmpty, !didSetColorsForSubscribedGroups else {
            didSetColorsForSubscribedGroups = true
            return
        }
        didSetColorsForSubscribedGroups = true
        var availableColors = FacultyGroupColor.allCases
        var newGroups: [FacultyGroup] = []

        for group in subscribedGroups {
            var group = group
            let color = availableColors.first
            group.color = color ?? .default
            availableColors.removeAll(where: { $0 == color })
            newGroups.append(group)
        }
        self.subscribedGroups = newGroups
    }
}
