//
//  FacultyGroupClassListItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import SwiftUI
import Widgets

struct FacultyGroupClassListItem: View {
    let facultyGroupClass: FacultyGroupClass
    let isSelected: Bool
    let action: (() -> Void)?

    var body: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .leading, spacing: .small) {
                Text(facultyGroupClass.name, style: .body)

                VStack(alignment: .leading, spacing: .micro) {
                    Text(facultyGroupClass.teacher, style: .footnote)
                    Text(facultyGroupClass.type, style: .footnote)
                }
                .foregroundColor(.gray)
            }
            .padding(.vertical, .micro)
            .frame(maxWidth: .infinity, alignment: .leading)

            if let action {
                Image.icon(isSelected ? .checkmark : .circle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundStyle(.accentPrimary)
                    .onTapGesture { action() }
            }
        }
        .card(vertical: .medium)
        .buttonStyle(.plain)
    }
}

#Preview {
    FacultyGroupClassListItem(facultyGroupClass: .sample, isSelected: true, action: {})
}
