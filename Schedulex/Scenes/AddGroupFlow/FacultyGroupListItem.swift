//
//  FacultyGroupListItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import Resources
import SwiftUI

struct FacultyGroupListItem: View {
    @State private var isDetailsViewPresented = false
    let facultyGroup: FacultyGroup

    var body: some View {
        BaseListItem(title: facultyGroup.name, caption: caption)
            .trailingIcon(.info) { isDetailsViewPresented = true }
            .sheet(isPresented: $isDetailsViewPresented) {
                FacultyGroupDetailsView(facultyGroup: facultyGroup)
            }
    }

    private var caption: String {
        "\(facultyGroup.numberOfEvents) " + L10n.xEvents
    }
}

#Preview {
    FacultyGroupListItem(facultyGroup: .sample)
}
