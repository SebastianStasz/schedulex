//
//  FacultyGroupView.swift
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

struct FacultyGroupView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @State private var facultyGroupEvents: FacultyGroupEvents?
    let facultyGroup: FacultyGroup

    var body: some View {
        ScrollView {
//            Button(isGroupSubscribed ? "Obserwowane" : "Dodaj do obserwowanych") {
//                guard !isGroupSubscribed else { return }
//                subscribedGroups.append(facultyGroup)
//            }
            ForEach(listSections ?? []) { section in
                Section {
                    VStack(spacing: .medium) {
                        ForEach(section.items, id: \.self) {
                            EventCardView(event: $0)
                        }
                    }
                } header: {
                    Text(section.title, style: .body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)
                        .padding(.top, 24)
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(facultyGroup.name)
        .baseListStyle(isLoading: facultyGroupEvents == nil)
        .task { facultyGroupEvents = try? await UekScheduleService().getFacultyGroupEvents(for: facultyGroup) }
    }

    private var isGroupSubscribed: Bool {
        subscribedGroups.contains(facultyGroup)
    }

    private var listSections: [ListSection<Event>]? {
        facultyGroupEvents?.events
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
        FacultyGroupView(facultyGroup: .sample)
    }
}
