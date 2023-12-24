//
//  MenuPicker.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 24/12/2023.
//

import SwiftUI

public protocol Pickable: Hashable {
    var title: String { get }
}

public struct MenuPicker<T: Pickable>: View {
    @Binding private var selectedOption: T
    private let title: String
    private let options: [T]

    public init(title: String, options: [T], selectedOption: Binding<T>) {
        self.title = title
        self.options = options
        _selectedOption = selectedOption
    }

    public var body: some View {
        HStack(spacing: .micro) {
            Text(title, style: .body)
                .foregroundStyle(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Menu {
                Picker(title, selection: $selectedOption) {
                    ForEach(options, id: \.self) {
                        SwiftUI.Text($0.title).tag($0)
                    }
                }
            } label: {
                Text(selectedOption.title, style: .body)
                    .foregroundStyle(.accentPrimary)
            }
        }
    }
}
