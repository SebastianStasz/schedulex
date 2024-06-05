//
//  FacultyGroupColorPickerView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 16/10/2023.
//

import Domain
import SwiftUI
import Widgets
import Resources
import SchedulexViewModel

struct FacultyGroupColorPickerView: RootView {
    @ObservedObject var store: FacultyGroupColorPickerStore

    var rootBody: some View {
        ScrollView {
            VStack(spacing: .large) {
                iconsRow(for: FacultyGroupColor.allCases.prefix(3))
                iconsRow(for: FacultyGroupColor.allCases.suffix(3))
            }
            .padding(.top, .large)
            .padding(.horizontal, .large)
        }
        .background(.backgroundPrimary)
    }

    private func iconsRow(for colors: ArraySlice<FacultyGroupColor>) -> some View {
        HStack(spacing: .large) {
            ForEach(colors) { color in
                ColorPickerSquare(color: color.representative, cornerRadius: .large)
                    .onTapGesture { store.setFacultyGroupColor.send(color) }
            }
        }
    }
}

final class FacultyGroupColorPickerViewController: SwiftUIViewController<FacultyGroupColorPickerViewModel, FacultyGroupColorPickerView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.selectColor
    }
}

#Preview {
    let store = FacultyGroupColorPickerStore(facultyGroup: .sample)
    return FacultyGroupColorPickerView(store: store)
}
