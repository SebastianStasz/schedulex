//
//  FacultyGroupView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Domain
import SwiftUI
import SchedulexFirebase

struct ListSection<T: Hashable>: Identifiable {
    let title: String
    let items: [T]

    var id: String { title }
}

struct FacultyGroupView: View {
    @State private var facultyGroupEvents: FacultyGroupEvents?
    let facultyGroup: FacultyGroup

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(listSections ?? []) { section in
                    Section {
                        ForEach(section.items, id: \.self) {
                            FacultyGroupListItemView(event: $0)
                        }
                    } header: {
                        Text(section.title)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 12)
                            .padding(.top, 24)
                    }

                }
            }
            .padding(.horizontal, 12)
        }
        .navigationTitle(facultyGroup.name)
        .task { facultyGroupEvents = try? await FirestoreService().getCracowUniversityOfEconomicsEvents(for: facultyGroup)}
    }

    private var listSections: [ListSection<Event>]? {
        facultyGroupEvents?.events
            .filter { $0.startDate != nil }
            .reduce(into: [ListSection<Event>](), { result, event in
                let date = event.startDateWithoutTime!.formatted(date: .long, time: .omitted)
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
