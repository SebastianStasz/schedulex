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
            return "Number of classes: \(facultyGroupDetails?.classes.count ?? 0)"
        }
        return "Ustaw widoczność zajęć"
    }

    private var eventsDescription: String {
        "Number of events: \(facultyGroupDetails?.events.count ?? 0)"
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

    var body: some View {
        NavigationStack {
            BaseList { 
                BaseListItem(title: L10n.classes, caption: classesDescription)
                    .navigationLink(value: Destination.classesList(facultyGroup.name, facultyGroupDetails?.classes ?? [], type))

                Separator()

                BaseListItem(title: L10n.events, caption: eventsDescription)
                    .navigationLink(value: Destination.eventsList(facultyGroup.name, facultyGroupDetails?.events ?? []))
            }
            .navigationDestination(for: Destination.self) { $0 }
            .baseListStyle(isLoading: facultyGroupDetails == nil)
            .navigationTitle(facultyGroup.name)
            .closeButton()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if isGroupSubscribed {
                        TextButton(L10n.unfollow) {
                            subscribedGroups.removeAll { $0.name == facultyGroup.name }
                            allHiddenClasses.removeAll { $0.facultyGroupName == facultyGroup.name }
                        }
                    } else {
                        TextButton(L10n.addToObserved) {
                            guard !isGroupSubscribed else { return }
                            subscribedGroups.append(facultyGroup)
                        }
                    }
                }
            }
        }
        .task { facultyGroupDetails = try? await UekScheduleService().getFacultyGroupDetails(for: facultyGroup) }
    }

    private var isGroupSubscribed: Bool {
        subscribedGroups.contains(facultyGroup)
    }
}

struct FacultyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupDetailsView(facultyGroup: .sample, type: .preview)
    }
}
