//
//  SearchField.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 08/10/2023.
//

import SwiftUI

public struct SearchField: View {
    @FocusState private var isFocused: Bool
    @Binding private var searchText: String
    private let prompt: String

    public init(prompt: String, searchText: Binding<String>) {
        self.prompt = prompt
        self._searchText = searchText
    }

    public var body: some View {
        HStack(spacing: .medium) {
            HStack(spacing: .micro) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)

                TextField(prompt, text: $searchText, prompt: promptText)
                    .focused($isFocused)
                    .submitLabel(.next)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .onSubmit { isFocused = true }
                    .textInputAutocapitalization(.characters)

                if !searchText.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .onTapGesture { searchText = "" }
                }
            }
            .padding(.small)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(.medium)
        }
        .padding(.horizontal, .large)
        .onTapGesture { isFocused = true }
        .onAppear { isFocused = true }
    }

    private var promptText: SwiftUI.Text {
        SwiftUI.Text(prompt).foregroundColor(.secondary)
    }

    private func cancelSearch() {
        searchText = ""
        isFocused = false
    }
}

#Preview {
    SearchField(prompt: "Prompt", searchText: .constant(""))
}
