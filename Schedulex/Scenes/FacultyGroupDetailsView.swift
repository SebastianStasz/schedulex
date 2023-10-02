//
//  FacultyGroupDetailsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Domain
import SwiftUI
import UEKScraper
import Widgets

struct ListSection<T: Hashable>: Identifiable {
    let title: String
    let items: [T]

    var id: String { title }
}

extension View {
    func navigationLink<T: Hashable>(value: T) -> some View {
        NavigationLink(value: value) { self }
    }
}

struct FacultyGroupDetailsView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @State private var facultyGroupDetails: FacultyGroupDetails?
    let facultyGroup: FacultyGroup

    enum Destination: Hashable, View {
        case classesList([FacultyGroupClass])
        case eventsList

        var body: some View {
            switch self {
            case let .classesList(classes):
                FacultyGroupClassesListView(classes: classes)
            case .eventsList:
                Text("")
            }
        }
    }

    var body: some View {
        //        ScrollView {
        NavigationStack {
            List {
                //            LazyVStack(pinnedViews: .sectionHeaders) {
                BaseListItem(title: "Classes", caption: "Number of classes: \(facultyGroupDetails?.classes.count ?? 0)")
                    .navigationLink(value: Destination.classesList(facultyGroupDetails?.classes ?? []))
                //                ForEach(listSections ?? []) { section in
                //                    Section {
                //                        VStack(spacing: .medium) {
                //                            ForEach(section.items, id: \.self) {
                //                                EventCardView(event: $0)
                //                            }
                //                        }
                //                    } header: {
                //                        Text(section.title, style: .body)
                //                            .frame(maxWidth: .infinity, alignment: .leading)
                //                            .foregroundStyle(.secondary)
                //                            .padding(.bottom, 12)
                //                            .padding(.top, 24)
                //                            .background(Color(uiColor: .systemGroupedBackground))
                //                    }
                //                }
                //            }
                //            .padding(.horizontal, 12)
            }
            .navigationDestination(for: Destination.self) { $0 }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(facultyGroup.name)
            .baseListStyle(isLoading: facultyGroupDetails == nil)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if isGroupSubscribed {
                        UnfollowGroupButton {
                            subscribedGroups.removeAll { $0.name == facultyGroup.name }
                        }
                        .labelStyle(.titleOnly)
                    } else {
                        Button("Dodaj do obserwowanych") {
                            guard !isGroupSubscribed else { return }
                            subscribedGroups.append(facultyGroup)
                        }
                    }
                }
            }
            .closeButton()
        }
        .task { facultyGroupDetails = try? await UekScheduleService().getFacultyGroupDetails(for: facultyGroup) }
    }

    private var isGroupSubscribed: Bool {
        subscribedGroups.contains(facultyGroup)
    }
    
    private var listSections: [ListSection<Event>]? {
        facultyGroupDetails?.events
            .filter { $0.startDate != nil }
            .reduce(into: [ListSection<Event>](), { result, event in
                let date = event.startDateWithoutTime!.formatted(style: .dateLong)
                if let sectionIndex = result.firstIndex(where: { $0.title == date }) {
                    let items = result[sectionIndex].items
                    result.remove(at: sectionIndex)
                    result.append(ListSection(title: date, items: items + [event]))
                } else {
                    result.append(ListSection(title: date, items: [event]))
                }
            })
    }
}

struct FacultyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupDetailsView(facultyGroup: .sample)
    }
}
