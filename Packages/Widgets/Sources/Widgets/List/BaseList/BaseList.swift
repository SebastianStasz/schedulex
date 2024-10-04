//
//  BaseList.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI

public struct BaseList<Content: View>: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                content()
            }
            .background(.backgroundTertiary)
            .cornerRadius(.medium)
            .padding(.top, .large)
            .padding(.bottom, .xlarge)
            .padding(.horizontal, .large)
        }
    }
}

public extension BaseList {
    @MainActor init<Data, ID, RowContent>(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element, TupleView<(RowContent, Separator?)>>, Data: RandomAccessCollection, ID: Hashable, RowContent: View, Data.Element: Hashable {
        self.init {
            ForEach(data, id: \.self) {
                rowContent($0)
                if data.last != $0 {
                    Separator()
                }
            }
        }
    }

    @MainActor init<Data, RowContent>(_ data: Data, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, TupleView<(RowContent, Separator?)>>, RowContent: View, Data.Element: Identifiable {
        let ids = data.map { $0.id }
        self.init {
            ForEach(data) {
                rowContent($0)
                if ids.last != $0.id {
                    Separator()
                }
            }
        }
    }
}

#Preview {
    BaseList([1, 2, 3, 4, 5], id: \.self) {
        Text("\($0)", style: .body)
    }
}
