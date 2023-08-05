//
//  FacultyGroupView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 05/08/2023.
//

import Domain
import SwiftUI
import SchedulexFirebase

struct FacultyGroupView: View {
    @State private var facultyGroupEvents: FacultyGroupEvents?
    let facultyGroup: FacultyGroup

    var body: some View {
        List(facultyGroupEvents?.events ?? [], id: \.self) { event in
            BaseListItem(title: event.name, caption: event.teacher)
        }
        .navigationTitle(facultyGroup.name)
        .task { facultyGroupEvents = try? await FirestoreService().getCracowUniversityOfEconomicsEvents(for: facultyGroup)}
    }
}

struct FacultyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupView(facultyGroup: .sample)
    }
}
