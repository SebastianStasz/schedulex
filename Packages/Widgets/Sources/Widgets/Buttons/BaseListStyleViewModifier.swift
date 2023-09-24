//
//  BaseListStyleViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 22/09/2023.
//

import SwiftUI

private struct BaseListStyleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .scrollContentBackground(.hidden)
    }

    private var backgroundColor: Color {
        Color(uiColor: .systemGroupedBackground)
    }
}

public extension View {
    func baseListStyle() -> some View {
        modifier(BaseListStyleViewModifier())
    }
}
