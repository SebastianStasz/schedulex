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
    public let emptyLabel: String
    public let isLazy: Bool

    public init(title: String, items: [Item], emptyLabel: String = "", isLazy: Bool = false) {
        self.title = title
        self.items = items
        self.emptyLabel = emptyLabel
        self.isLazy = isLazy
    }
}

public struct SectionedList<Item: Hashable, RowContent: View>: View {
    private let sections: [ListSection<Item>]
    private let rowContent: (Int, Item) -> RowContent
    private let separatorHeight: CGFloat
    private let pinnedHeaders: Bool

    public init(_ sections: [ListSection<Item>], pinnedHeaders: Bool = false, separatorHeight: CGFloat = 1, @ViewBuilder rowContent: @escaping (Int, Item) -> RowContent) {
        self.sections = sections
        self.rowContent = rowContent
        self.pinnedHeaders = pinnedHeaders
        self.separatorHeight = separatorHeight
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: pinnedHeaders ? [.sectionHeaders] : []) {
                ForEach(Array(zip(sections.indices, sections)), id: \.0) { sectionIndex, section in
                    Section(content: { rowsView(for: section, sectionIndex: sectionIndex) },
                            header: { headerView(title: section.title) })
                    .id(sectionIndex)
                }
            }
            .padding(.top, .medium)
            .padding(.horizontal, .large)
        }
    }

    private func headerView(title: String) -> some View {
        Text(title, style: .body)
            .foregroundStyle(.grayShade1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, .medium)
            .background(.backgroundPrimary)
    }

    @ViewBuilder
    private func rowsView(for section: ListSection<Item>, sectionIndex: Int) -> some View {
        if section.items.isEmpty {
            Text(section.emptyLabel, style: .footnote)
                .frame(maxWidth: .infinity)
                .padding(.vertical, .large)
        } else {
            Group {
                if section.isLazy {
                    LazyVStack(spacing: 0) {
                        rowsContent(for: section, sectionIndex: sectionIndex)
                    }
                } else {
                    VStack(spacing: 0) {
                        rowsContent(for: section, sectionIndex: sectionIndex)
                    }
                }
            }
            .background(.backgroundTertiary)
            .cornerRadius(.medium)
            .padding(.bottom, .xlarge)
        }
    }

    private func rowsContent(for section: ListSection<Item>, sectionIndex: Int) -> some View {
        ForEach(section.items, id: \.self) {
            rowContent(sectionIndex, $0)
            Separator(height: separatorHeight)
                .displayIf(section.items.last != $0)
        }
    }
}
