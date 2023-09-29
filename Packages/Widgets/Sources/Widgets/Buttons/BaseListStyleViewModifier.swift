//
//  BaseListStyleViewModifier.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 22/09/2023.
//

import SwiftUI

private struct BaseListStyleViewModifier: ViewModifier {
    let isEmpty: Bool
    let isLoading: Bool

    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .overlay {
                ZStack {
                    emptyBackground
                    loadingIndicator
                }
            }
            .scrollContentBackground(.hidden)
    }

    @ViewBuilder
    private var emptyBackground: some View {
        if isEmpty || isLoading {
            backgroundColor.ignoresSafeArea()
        }
    }

    @ViewBuilder
    private var loadingIndicator: some View {
        if isLoading { ProgressView() }
    }

    private var backgroundColor: Color {
        Color(uiColor: .systemGroupedBackground)
    }
}

public extension View {
    func baseListStyle(isEmpty: Bool = false, isLoading: Bool = false) -> some View {
        modifier(BaseListStyleViewModifier(isEmpty: isEmpty, isLoading: isLoading))
    }
}
