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
            let isSelected = !facultyGroup.isHidden
            let editGroup = { store.editFacultyGroup.send(facultyGroup) }

            if facultyGroup == store.subscribedGroups.first {
                addGroupRow()
                Separator()
            }

            BaseListItem(facultyGroup: facultyGroup, icon: .edit, iconSize: .xlarge, iconAction: editGroup) {
                SelectionIcon(isSelected: isSelected, color: facultyGroup.color.representative)
                    .frame(height: .xlarge)
            }
            .onTapGesture { store.toggleFacultyGroupVisibility.send(facultyGroup) }
            .contextMenu { UnfollowGroupButton { store.groupToDelete = facultyGroup } }
        }
        .confirmationDialogUnfollowGroup(name: store.groupToDelete?.name, isPresented: store.isGroupDeleteConfirmationPresented, action: store.deleteFacultyGroup.send)
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
