//
//  BaseListItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Resources
import SwiftUI

public struct BaseListItem<Content: View>: View {
    private let title: String
    private let caption: String
    private let icon: Icon
    private let iconColor: Color
    private let iconSize: CGFloat
    private let iconAction: (() -> Void)?
    private let content: Content

    public init(title: String, caption: String, icon: Icon, iconColor: Color = .accentPrimary, iconSize: CGFloat = 20, iconAction: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.caption = caption
        self.icon = icon
        self.iconColor = iconColor
        self.iconSize = iconSize
        self.iconAction = iconAction
        self.content = content()
    }

    public var body: some View {
        HStack(spacing: .large) {
            content

            VStack(alignment: .leading, spacing: .micro) {
                Text(title, style: .body)
                    .foregroundStyle(.textPrimary)
                    .multilineTextAlignment(.leading)

                Text(caption, style: .footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let iconAction {
                iconView()
                    .contentShape(Rectangle())
                    .onTapGesture(perform: iconAction)
            } else {
                iconView()
            }
        }
        .card()
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }

    private func iconView() -> some View {
        Image.icon(icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: iconSize, height: iconSize)
            .foregroundStyle(iconColor)
    }
}

public extension BaseListItem {
    init(facultyGroup: FacultyGroup, icon: Icon, iconColor: Color = .accentPrimary, iconSize: CGFloat = 20, iconAction: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        let caption = L10n.numberOfEvents + " \(facultyGroup.numberOfEvents)"
        self.init(title: facultyGroup.name, caption: caption, icon: icon, iconColor: iconColor, iconSize: iconSize, iconAction: iconAction, content: content)
    }
}

public extension BaseListItem where Content == EmptyView {
    init(title: String, caption: String, icon: Icon, iconColor: Color = .accentPrimary, iconSize: CGFloat = 20) {
        self.init(title: title, caption: caption, icon: icon, iconColor: iconColor, iconSize: iconSize, content: { EmptyView() })
    }

    init(facultyGroup: FacultyGroup, icon: Icon, iconColor: Color = .accentPrimary, iconSize: CGFloat = 20) {
        let caption = L10n.numberOfEvents + " \(facultyGroup.numberOfEvents)"
        self.init(title: facultyGroup.name, caption: caption, icon: icon, iconColor: iconColor, iconSize: iconSize, content: { EmptyView() })
    }
}

#Preview {
    BaseListItem(title: "ZIISSS2-2411IS", caption: "Number of events: 81", icon: .edit)
}
