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
    @AppStorage("hiddenFacultyGroupsClasses") private var allHiddenClasses: [EditableFacultyGroupClass] = []
    @State private var isFacultiesListPresented = false
    @State private var groupToDelete: FacultyGroup?
    @State private var facultyGroup: FacultyGroup?
    let service: FirestoreService

    private var isGroupDeleteConfirmationPresented: Binding<Bool> {
        Binding(get: { groupToDelete != nil }, set: { _ in groupToDelete = nil })
    }

    var body: some View {
        BaseList(subscribedGroups.sorted(by: { $0.name < $1.name })) { facultyGroup in
            let caption = "\(facultyGroup.numberOfEvents) " + L10n.xEvents
            let isSelected = !facultyGroup.isHidden
            let action = { self.facultyGroup = facultyGroup }

            ObservedFacultyGroupItem(title: facultyGroup.name, caption: caption, color: facultyGroup.color.representative, isSelected: isSelected, trailingIconAction: action)
            .onTapGesture { hideOrShowGroup(facultyGroup) }
            .contextMenu { UnfollowGroupButton { groupToDelete = facultyGroup } }
        }
        .confirmationDialog(unfollowGroupQuestion, isPresented: isGroupDeleteConfirmationPresented, titleVisibility: .visible) {
            Button(L10n.unfollow, role: .destructive, action: deleteGroup)
        }
        .sheet(item: $facultyGroup) { FacultyGroupDetailsView(facultyGroup: $0, type: .editable) }
        .sheet(isPresented: $isFacultiesListPresented) { FacultiesListView(service: service) }
        .baseListStyle(isEmpty: subscribedGroups.isEmpty)
        .navigationTitle(L10n.observedTitle)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { toolbarContent }
    }

    private var unfollowGroupQuestion: String {
        L10n.unfollowGroupQuestion + " \(groupToDelete?.name ?? "")?"
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            TextButton(L10n.addGroup) { isFacultiesListPresented = true }
        }
    }

    private func hideOrShowGroup(_ group: FacultyGroup) {
        guard let index = subscribedGroups.firstIndex(where: { $0.name == group.name }) else {
            return
        }
        subscribedGroups[index].isHidden.toggle()
    }

    private func deleteGroup() {
        guard let groupToDelete else { return }
        subscribedGroups.removeAll { $0.name == groupToDelete.name }
        allHiddenClasses.removeAll { $0.facultyGroupName == groupToDelete.name }
        self.groupToDelete = nil
    }
}

#Preview {
    ObservedFacultyGroupsView(service: FirestoreService())
}
