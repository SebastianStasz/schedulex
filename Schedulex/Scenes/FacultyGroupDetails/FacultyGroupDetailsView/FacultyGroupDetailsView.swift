//
//  FacultyGroupDetailsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Domain
import Resources
import SchedulexViewModel
import SwiftUI
import UEKScraper
import Widgets

struct FacultyGroupDetailsView: RootView {
    @State private var isGroupDeleteConfirmationPresented = false
    @ObservedObject var store: FacultyGroupDetailsStore

    var rootBody: some View {
        BaseList {
            if store.viewType == .editable {
                NavigationRow(title: L10n.color, caption: L10n.changeColorOfEvents, action: store.navigateToColorSelection.send) {
                    ColorPickerSquare(color: store.facultyGroup.color.representative, cornerRadius: .mini)
                        .fixedSize(horizontal: true, vertical: false)
                }
                Separator()
            }
            NavigationRow(title: L10n.classes, caption: classesDescription, action: store.navigateToClassList.send)
            Separator()
            NavigationRow(title: L10n.events, caption: eventsDescription, action: store.navigateToEventsList.send)
        }
        .baseListStyle(isLoading: isLoading)
        .safeAreaInset(edge: .bottom, content: bottomButton)
        .confirmationDialogUnfollowGroup(name: store.facultyGroup.name, isPresented: $isGroupDeleteConfirmationPresented, action: store.unsubscribeFacultyGroup.send)
    }

    private func bottomButton() -> some View {
        Group {
            UnfollowGroupButton { isGroupDeleteConfirmationPresented = true }
                .opacity(store.isFacultyGroupSubscribed ? 1 : 0)

            FollowGroupButton { store.subscribeFacultyGroup.send() }
                .opacity(store.isFacultyGroupSubscribed ? 0 : 1)
        }
        .opacity(isLoading ? 0 : 1)
        .padding(.bottom, .large)
    }

    private var classesDescription: String {
        if case store.viewType = .preview {
            return L10n.numberOfClasses + " \(store.facultyGroupDetails?.classes.count ?? 0)"
        }
        return L10n.setClassesVisibility
    }

    private var eventsDescription: String {
        L10n.numberOfEvents + " \(store.facultyGroupDetails?.events.count ?? 0)"
    }

    private var isLoading: Bool {
        store.facultyGroupDetails == nil
    }
}

final class FacultyGroupDetailsViewController: SwiftUIViewController<FacultyGroupDetailsViewModel, FacultyGroupDetailsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.facultyGroup.name
    }
}

#Preview {
    let store = FacultyGroupDetailsStore(facultyGroup: .sample, viewType: .preview)
    return FacultyGroupDetailsView(store: store)
}
