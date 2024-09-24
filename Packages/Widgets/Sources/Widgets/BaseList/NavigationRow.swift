//
//  NavigationRow.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 22/09/2024.
//

import Domain
import Resources
import SwiftUI

public struct NavigationRow<Content: View>: View {
    private let title: String
    private let caption: String
    private let color: Color?
    private let content: () -> Content
    private let action: () -> Void

    public init(title: String, caption: String, color: Color? = nil, action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.caption = caption
        self.color = color
        self.content = content
        self.action = action
    }

    public var body: some View {
        BaseListItem(title: title, caption: caption, icon: .chevronRight, iconSize: 15, content: content)
            .onTapGesture(perform: action)
    }
}

public extension NavigationRow where Content == EmptyView {
    init(title: String, caption: String, color: Color? = nil, action: @escaping () -> Void) {
        self.init(title: title, caption: caption, color: color, action: action, content: { EmptyView() })
    }

    init(facultyGroup: FacultyGroup, action: @escaping () -> Void) {
        let caption = L10n.numberOfEvents + " \(facultyGroup.numberOfEvents)"
        self.init(title: facultyGroup.name, caption: caption, action: action, content: { EmptyView() })
    }
}

#Preview {
    NavigationRow(title: "ZIISSS2-2411IS", caption: "Number of events: 81", action: {})
}
