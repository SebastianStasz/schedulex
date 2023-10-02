//
//  ObservedFacultyGroupsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/09/2023.
//

import Domain
import Resources
import SchedulexFirebase
import SwiftUI
import Widgets

struct ObservedFacultyGroupsView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @State private var isFacultiesListPresented = false
    @State private var groupToDelete: FacultyGroup?
    let service: FirestoreService

    private var isGroupDeleteConfirmationPresented: Binding<Bool> {
        Binding(get: { groupToDelete != nil }, set: { _ in groupToDelete = nil })
    }

    var body: some View {
        NavigationStack {
            List(subscribedGroups) { facultyGroup in
                FacultyGroupListItem(facultyGroup: facultyGroup)
                    .contextMenu {
                        UnfollowGroupButton { groupToDelete = facultyGroup }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        UnfollowGroupButton(destructive: false) { groupToDelete = facultyGroup }
                    }
            }
            .confirmationDialog(unfollowGroupQuestion, isPresented: isGroupDeleteConfirmationPresented, titleVisibility: .visible) {
                Button(L10n.unfollow, role: .destructive, action: deleteGroup)
            }
            .sheet(isPresented: $isFacultiesListPresented) { FacultiesListView(service: service) }
            .baseListStyle(isEmpty: subscribedGroups.isEmpty)
            .navigationTitle(L10n.observedTitle)
            .toolbar { toolbarContent }
            .closeButton()
        }
    }

    private var unfollowGroupQuestion: String {
        L10n.unfollowGroupQuestion + " \(groupToDelete?.name ?? "")?"
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button(L10n.addGroup) { isFacultiesListPresented = true }
                .foregroundStyle(.accentPrimary)
        }
    }

    private func deleteGroup() {
        guard let groupToDelete else { return }
        subscribedGroups.removeAll { $0.name == groupToDelete.name }
        self.groupToDelete = nil
    }
}

#Preview {
    ObservedFacultyGroupsView(service: FirestoreService())
}
