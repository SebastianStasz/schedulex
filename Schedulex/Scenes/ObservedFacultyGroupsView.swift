//
//  ObservedFacultyGroupsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/09/2023.
//

import Domain
import SwiftUI
import Widgets
import SchedulexFirebase

struct ObservedFacultyGroupsView: View {
    let service: FirestoreService
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @State private var groupToDelete: FacultyGroup?

    private var isGroupDeleteConfirmationPresented: Binding<Bool> {
        Binding(get: { groupToDelete != nil }, set: { _ in groupToDelete = nil })
    }

    var body: some View {
        NavigationStack {
            List(subscribedGroups, id: \.self) { facultyGroup in
                BaseListItem(title: facultyGroup.name, caption: "\(facultyGroup.numberOfEvents) events")
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
                SchoolView(service: service)
            }
            .confirmationDialog("Do you want to unfollow group \(groupToDelete?.name ?? "")?", isPresented: isGroupDeleteConfirmationPresented, titleVisibility: .visible) {
                Button("Unfollow", role: .destructive, action: deleteGroup)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(value: "SchoolView") {
                        Label("Add", systemImage: "plus")
                            .font(.title2)
                    }
                }
            }
            .navigationTitle("Obserwowane")
            .baseListStyle()
        }
    }

    private func deleteGroup() {
        guard let groupToDelete else { return }
        subscribedGroups.removeAll(where: { $0.name == groupToDelete.name })
        self.groupToDelete = nil
    }
}

#Preview {
    ObservedFacultyGroupsView(service: FirestoreService())
}
