//
//  ObservedFacultyGroupsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/09/2023.
//

import Domain
import Resources
import SchedulexViewModel
import SwiftUI
import Widgets

struct ObservedFacultyGroupsView: RootView {
    @ObservedObject var store: ObservedFacultyGroupsStore

    var rootBody: some View {
        BaseList(store.subscribedGroups) { facultyGroup in
            let caption = L10n.numberOfEvents + " \(facultyGroup.numberOfEvents)"
            let isSelected = !facultyGroup.isHidden
            let action = { store.editFacultyGroup.send(facultyGroup) }

            if facultyGroup == store.subscribedGroups.first {
                addGroupRow()
                Separator()
            }

            ObservedFacultyGroupItem(title: facultyGroup.name, caption: caption, color: facultyGroup.color.representative, isSelected: isSelected, trailingIconAction: action)
                .onTapGesture { store.toggleFacultyGroupVisibility.send(facultyGroup) }
                .contextMenu { UnfollowGroupButton { store.groupToDelete = facultyGroup } }
        }
        .confirmationDialog(unfollowGroupQuestion, isPresented: store.isGroupDeleteConfirmationPresented, titleVisibility: .visible) {
            Button(L10n.unfollow, role: .destructive, action: store.deleteFacultyGroup.send)
        }
    }

    private func addGroupRow() -> some View {
        HStack(spacing: .large) {
            Image.icon(.plusCircle)
                .resizable()
                .scaledToFit()
                .fontWeight(.thin)
                .frame(height: .xlarge)

            Text(L10n.addGroup, style: .body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .card(vertical: .xlarge)
        .foregroundStyle(.accentPrimary)
        .onTapGesture(perform: store.presentFacultiesList.send)
    }

    private var unfollowGroupQuestion: String {
        L10n.unfollowGroupQuestion + " \(store.groupToDelete?.name ?? "")?"
    }
}

final class ObservedFacultyGroupsStoreViewController: SwiftUIViewController<ObservedFacultyGroupsViewModel, ObservedFacultyGroupsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.observedTitle
    }
}

#Preview {
    ObservedFacultyGroupsView(store: ObservedFacultyGroupsStore())
}
