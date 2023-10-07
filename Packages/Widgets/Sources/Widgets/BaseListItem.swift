//
//  BaseListItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import SwiftUI

public struct BaseListItem: View {
    let title: String
    let caption: String?
    var trailingIcon: Icon?
    var iconColor: Color = .accentPrimary
    var iconSize: CGFloat = 20

    public init(title: String, caption: String? = nil) {
        self.title = title
        self.caption = caption
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .micro) {
                Text(title, style: .body)
                    .foregroundStyle(.textPrimary)
                    .multilineTextAlignment(.leading)

                if let caption {
                    Text(caption, style: .footnote)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image.icon(trailingIcon ?? .delete)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: iconSize)
                .foregroundStyle(iconColor)
                .opacity(trailingIcon == nil ? 0 : 1)
        }
        .card()
        .buttonStyle(.plain)
    }
}

public extension BaseListItem {
    func trailingIcon(_ icon: Icon, iconColor: Color = .accentPrimary, iconSize: CGFloat = 20) -> some View {
        var view = self
        view.trailingIcon = icon
        view.iconColor = iconColor
        view.iconSize = iconSize
        return view
    }
}

struct BaseListItem_Previews: PreviewProvider {
    static var previews: some View {
        BaseListItem(title: "Title", caption: "caption")
    }
}
