//
//  FacultyGroupDetailsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Domain
import Resources
import SwiftUI
import UEKScraper
import Widgets

extension View {
    func navigationLink<T: Hashable>(value: T) -> some View {
        NavigationLink(value: value) { self }
    }
}

final class FacultyGroupDetailsViewController: SwiftUIViewController<FacultyGroupDetailsViewModel, FacultyGroupDetailsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.facultyGroup.name
    }
}

struct FacultyGroupDetailsView: RootView {
    @ObservedObject var store: FacultyGroupDetailsStore

    @AppStorage("hiddenFacultyGroupsClasses") private var allHiddenClasses: [EditableFacultyGroupClass] = []
    let type: ViewType = .editable

    enum ViewType {
        case preview
        case editable
    }

    private var classesDescription: String {
        if case type = .preview {
            return L10n.numberOfClasses + " \(store.facultyGroupDetails?.classes.count ?? 0)"
        }
        return L10n.setClassesVisibility
    }

    private var eventsDescription: String {
        L10n.numberOfEvents + " \(store.facultyGroupDetails?.events.count ?? 0)"
    }

    enum Destination: Hashable, View {
        case classesList(String, [FacultyGroupClass], ViewType)
        case eventsList(String, [Event])

        var body: some View {
            switch self {
            case let .classesList(facultyGroupName, classes, type):
                FacultyGroupClassListView(facultyGroupName: facultyGroupName, classes: classes, viewType: type)
            case let .eventsList(facultyGroupName, events):
                FacultyGroupEventListView(facultyGroupName: facultyGroupName, events: events)
            }
        }
    }

    var rootBody: some View {
            BaseList {
                if type == .editable {
                    BaseListItem(title: L10n.color, caption: L10n.changeColorOfEvents, color: store.facultyGroup.color.representative)
                        .trailingIcon(.chevronRight, iconSize: 15)
                        .buttonStyle(.plain)
                        .onTapGesture { store.navigateToColorSelection.send() }

                    Separator()
                }

                BaseListItem(title: L10n.classes, caption: classesDescription)
                    .trailingIcon(.chevronRight, iconSize: 15)
//                    .navigationLink(value: Destination.classesList(facultyGroup.name, facultyGroupDetails?.classes ?? [], type))
                    .buttonStyle(.plain)

                Separator()

                BaseListItem(title: L10n.events, caption: eventsDescription)
                    .trailingIcon(.chevronRight, iconSize: 15)
//                    .navigationLink(value: Destination.eventsList(facultyGroup.name, facultyGroupDetails?.events ?? []))
                    .buttonStyle(.plain)
            }
//            .baseListStyle(isLoading: facultyGroupDetails == nil)
            .safeAreaInset(edge: .bottom) {
                TextButton(store.isFacultyGroupSubscribed ? L10n.unfollow : L10n.addToObserved) {
                    if store.isFacultyGroupSubscribed {
                        store.unsubscribeFacultyGroup.send()
                    } else {
                        store.subscribeFacultyGroup.send()
//                        guard !isGroupSubscribed else { return }
//                        let availableColors = FacultyGroupColor.allCases.filter { color in
//                            !subscribedGroups.contains(where: { $0.color == color })
//                        }
//                        var facultyGroup = facultyGroup
//                        facultyGroup.color = availableColors.first ?? .default
//                        subscribedGroups.append(facultyGroup)
                    }
                }
                .padding(.bottom, .large)
            }
    }

//    private var isGroupSubscribed: Bool {
//        subscribedGroups.contains(where: { $0.name == facultyGroup.name })
//    }
}

struct FacultyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupDetailsView(store: FacultyGroupDetailsStore(facultyGroup: .sample))
    }
}
