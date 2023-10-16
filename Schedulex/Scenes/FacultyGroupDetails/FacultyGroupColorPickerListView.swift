//
//  FacultyGroupColorPickerListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 16/10/2023.
//

import Domain
import SwiftUI
import Widgets
import Resources

struct FacultyGroupColorPickerListView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @Environment(\.dismiss) private var dismiss
    let facultyGroup: FacultyGroup

    var body: some View {
        ScrollView {
            VStack(spacing: .large) {
                iconsRow(for: FacultyGroupColor.allCases.prefix(3))
                iconsRow(for: FacultyGroupColor.allCases.suffix(3))
            }
            .padding(.top, .large)
            .padding(.horizontal, .large)
        }
        .background(.backgroundPrimary)
        .navigationTitle(L10n.selectColor)
    }

    private func iconsRow(for colors: ArraySlice<FacultyGroupColor>) -> some View {
        HStack(spacing: .large) {
            ForEach(colors) { color in
                ColorPickerSquare(color: color.representative, cornerRadius: .large)
                    .onTapGesture { selectColor(color) }
            }
        }
    }

    private func selectColor(_ color: FacultyGroupColor) {
        dismiss.callAsFunction()
        guard let index = subscribedGroups.firstIndex(where: { $0.name == facultyGroup.name }) else { return }
        subscribedGroups[index].color = color
    }
}

#Preview {
    FacultyGroupColorPickerListView(facultyGroup: .sample)
}
