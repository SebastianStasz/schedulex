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
    @ObservedObject var store: FacultyGroupDetailsStore

    var rootBody: some View {
        BaseList {
            if store.viewType == .editable {
                BaseListItem(title: L10n.color, caption: L10n.changeColorOfEvents, color: store.facultyGroup.color.representative)
                    .trailingIcon(.chevronRight, iconSize: 15)
                    .onTapGesture { store.navigateToColorSelection.send() }

                Separator()
            }

            BaseListItem(title: L10n.classes, caption: classesDescription)
                .trailingIcon(.chevronRight, iconSize: 15)
                .onTapGesture { store.navigateToClassList.send() }

            Separator()

            BaseListItem(title: L10n.events, caption: eventsDescription)
                .trailingIcon(.chevronRight, iconSize: 15)
                .onTapGesture { store.navigateToEventsList.send() }
        }
        .baseListStyle(isLoading: isLoading)
        .safeAreaInset(edge: .bottom) {
            Button(store.isFacultyGroupSubscribed ? L10n.unfollow : L10n.addToObserved) {
                store.subscribeOrUnsubscribeFacultyGroup.send()
            }
            .foregroundStyle(.red)
            .padding(.bottom, .large)
            .opacity(isLoading ? 0 : 1)
        }
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
