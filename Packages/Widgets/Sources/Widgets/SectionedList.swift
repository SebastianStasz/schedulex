//
//  SectionedList.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

public struct ListSection<Item: Hashable>: Hashable {
    public let title: String
    public let items: [Item]

    public init(title: String, items: [Item]) {
        self.title = title
        self.items = items
    }
}

public struct SectionedList<Item: Hashable, RowContent: View>: View {
    private let sections: [ListSection<Item>]
    private let rowContent: (Item) -> RowContent
    private let separatorHeight: CGFloat

    public init(_ sections: [ListSection<Item>], separatorHeight: CGFloat = 1, @ViewBuilder rowContent: @escaping (Item) -> RowContent) {
        self.sections = sections
        self.rowContent = rowContent
        self.separatorHeight = separatorHeight
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(sections, id: \.self) { section in
                    Section(content: { rowsView(for: section.items) },
                            header: { headerView(title: section.title) })
                }
            }
            .padding(.bottom, .xlarge)
            .padding(.horizontal, .large)
            .padding(.top, -.xlarge)
        }
    }

    private func headerView(title: String) -> some View {
        Text(title, style: .body)
            .foregroundStyle(.grayShade1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, .medium)
            .padding(.top, 40)
    }

    private func rowsView(for items: [Item]) -> some View {
        LazyVStack(spacing: 0) {
            ForEach(items, id: \.self) {
                rowContent($0)
                Separator(height: separatorHeight)
                    .displayIf(items.last != $0)
            }
        }
        .background(.backgroundTertiary)
        .cornerRadius(.medium)
    }
}
