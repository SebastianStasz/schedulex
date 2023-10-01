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
    @State private var groupToDelete: FacultyGroup?
    let service: FirestoreService

    private var isGroupDeleteConfirmationPresented: Binding<Bool> {
        Binding(get: { groupToDelete != nil }, set: { _ in groupToDelete = nil })
    }

    var body: some View {
        NavigationStack {
            List(subscribedGroups) { facultyGroup in
                BaseListItem(title: facultyGroup.name, caption: "\(facultyGroup.numberOfEvents) " + L10n.xEvents)
                    .contextMenu {
                        Button(role: .destructive, action: { groupToDelete = facultyGroup }) {
                            Label("Unfollow", systemImage: "trash.fill")
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(action: { groupToDelete = facultyGroup }) {
                            Label("Unfollow", systemImage: "trash.fill")
                        }
                        .tint(.red)
                    }
            }
            .navigationDestination(for: Faculty.self) {
                FacultyGroupsList(faculty: $0)
            }
            .navigationDestination(for: FacultyGroup.self) {
                FacultyGroupView(facultyGroup: $0)
            }
            .navigationDestination(for: String.self) { _ in
                FacultiesListView(service: service)
            }
            .confirmationDialog(unfollowGroupQuestion, isPresented: isGroupDeleteConfirmationPresented, titleVisibility: .visible) {
                Button(L10n.unfollow, role: .destructive, action: deleteGroup)
            }
            .baseListStyle(isEmpty: subscribedGroups.isEmpty)
            .navigationTitle(L10n.observedTitle)
            .toolbar { toolbarContent }
        }
    }

    private var unfollowGroupQuestion: String {
        L10n.unfollowGroupQuestion + " \(groupToDelete?.name ?? "")?"
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            NavigationLink(value: "FacultiesListView") {
                Label("Add", systemImage: "plus")
                    .font(.title2)
            }
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
