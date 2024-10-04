//
//  SearchField.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 08/10/2023.
//

import Resources
import SwiftUI

public struct SearchField: View {
    @FocusState private var focusState: Bool
    @Binding private var isFocused: Bool
    @Binding private var searchText: String
    private let prompt: String

    public init(prompt: String, searchText: Binding<String>, isFocused: Binding<Bool>) {
        self.prompt = prompt
        _searchText = searchText
        _isFocused = isFocused
    }

    public var body: some View {
        HStack(spacing: .medium) {
            HStack(spacing: .micro) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)

                TextField(prompt, text: $searchText, prompt: promptText)
                    .focused($focusState)
                    .submitLabel(.next)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .onSubmit { focusState = true }
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

            if focusState {
                TextButton(L10n.cancelButton, style: .bodyMedium, color: .textPrimary, action: cancelSearch)
            }
        }
        .padding(.horizontal, .large)
        .onTapGesture { focusState = true }
        .onChange(of: isFocused) { focusState = $0 }
        .onChange(of: focusState) { isFocused = $0 }
    }

    private var promptText: SwiftUI.Text {
        SwiftUI.Text(prompt).foregroundColor(.secondary)
    }

    private func cancelSearch() {
        searchText = ""
        focusState = false
    }
}

#Preview {
    SearchField(prompt: "Prompt", searchText: .constant(""), isFocused: .constant(false))
}
