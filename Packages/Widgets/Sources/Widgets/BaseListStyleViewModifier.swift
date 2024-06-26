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
    let isSearching: Bool

    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    emptyBackground
                    loadingIndicator
                    emptyStateView
                }
            }
            .allowsHitTesting(!isLoading)
    }

    @ViewBuilder
    private var emptyBackground: some View {
        if (isEmpty || isLoading) && !isSearching {
            backgroundColor.ignoresSafeArea()
        }
    }

    @ViewBuilder
    private var loadingIndicator: some View {
        if isLoading { ProgressView() }
    }

    @ViewBuilder
    private var emptyStateView: some View {
        if isEmpty && !isLoading && !isSearching {
            EmptyStateView()
                .padding(.bottom, 60)
        }
    }

    private var backgroundColor: Color {
        Color.backgroundPrimary
    }
}

public extension View {
    func baseListStyle(isEmpty: Bool = false, isLoading: Bool = false, isSearching: Bool = false) -> some View {
        modifier(BaseListStyleViewModifier(isEmpty: isEmpty, isLoading: isLoading, isSearching: isSearching))
    }
}
