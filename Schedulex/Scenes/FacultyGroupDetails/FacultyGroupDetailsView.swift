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

struct FacultyGroupDetailsView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @AppStorage("hiddenFacultyGroupsClasses") private var allHiddenClasses: [EditableFacultyGroupClass] = []
    @State private var facultyGroupDetails: FacultyGroupDetails?
    let facultyGroup: FacultyGroup
    let type: ViewType

    enum ViewType {
        case preview
        case editable
    }

    private var classesDescription: String {
        if case type = .preview {
            return L10n.numberOfClasses + " \(facultyGroupDetails?.classes.count ?? 0)"
        }
        return L10n.setClassesVisibility
    }

    private var eventsDescription: String {
        L10n.numberOfEvents + " \(facultyGroupDetails?.events.count ?? 0)"
    }

    enum Destination: Hashable, View {
        case colorPicker(FacultyGroup)
        case classesList(String, [FacultyGroupClass], ViewType)
        case eventsList(String, [Event])

        var body: some View {
            switch self {
            case let .colorPicker(facultyGroup):
                FacultyGroupColorPickerListView(facultyGroup: facultyGroup)
            case let .classesList(facultyGroupName, classes, type):
                FacultyGroupClassListView(facultyGroupName: facultyGroupName, classes: classes, viewType: type)
            case let .eventsList(facultyGroupName, events):
                FacultyGroupEventListView(facultyGroupName: facultyGroupName, events: events)
            }
        }
    }

    var body: some View {
        NavigationStack {
            BaseList {
                if type == .editable {
                    BaseListItem(title: "Color", caption: "Change color for events", color: (subscribedGroups.first(where: { $0.name == facultyGroup.name })?.color ?? .default).representative)
                        .trailingIcon(.chevronRight, iconSize: 15)
                        .navigationLink(value: Destination.colorPicker(facultyGroup))
                        .buttonStyle(.plain)

                    Separator()
                }

                BaseListItem(title: L10n.classes, caption: classesDescription)
                    .trailingIcon(.chevronRight, iconSize: 15)
                    .navigationLink(value: Destination.classesList(facultyGroup.name, facultyGroupDetails?.classes ?? [], type))
                    .buttonStyle(.plain)

                Separator()

                BaseListItem(title: L10n.events, caption: eventsDescription)
                    .trailingIcon(.chevronRight, iconSize: 15)
                    .navigationLink(value: Destination.eventsList(facultyGroup.name, facultyGroupDetails?.events ?? []))
                    .buttonStyle(.plain)
            }
            .navigationDestination(for: Destination.self) { $0 }
            .baseListStyle(isLoading: facultyGroupDetails == nil)
            .navigationTitle(facultyGroup.name)
            .closeButton()
            .safeAreaInset(edge: .bottom) {
                TextButton(isGroupSubscribed ? L10n.unfollow : L10n.addToObserved) {
                    if isGroupSubscribed {
                        subscribedGroups.removeAll { $0.name == facultyGroup.name }
                        allHiddenClasses.removeAll { $0.facultyGroupName == facultyGroup.name }
                    } else {
                        guard !isGroupSubscribed else { return }
                        let availableColors = FacultyGroupColor.allCases.filter { color in
                            !subscribedGroups.contains(where: { $0.color == color })
                        }
                        var facultyGroup = facultyGroup
                        facultyGroup.color = availableColors.first ?? .default
                        subscribedGroups.append(facultyGroup)
                    }
                }
                .padding(.bottom, .large)
            }
        }
        .task { facultyGroupDetails = try? await UekScheduleService().getFacultyGroupDetails(for: facultyGroup) }
    }

    private var isGroupSubscribed: Bool {
        subscribedGroups.contains(where: { $0.name == facultyGroup.name })
    }
}

struct FacultyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupDetailsView(facultyGroup: .sample, type: .preview)
    }
}
