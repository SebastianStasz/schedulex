//
//  BaseListItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import SwiftUI
import Widgets

struct BaseListItem: View {
    let title: String
    let caption: String?
    var trailingIcon: Icon?
    var trailingIconAction: () -> Void = {}

    init(title: String, caption: String? = nil) {
        self.title = title
        self.caption = caption
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .micro) {
                Text(title)

                if let caption {
                    Text(caption, style: .note)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let trailingIcon {
                Image.icon(trailingIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundStyle(.accentPrimary)
                    .onTapGesture { trailingIconAction() }
            }
        }
        .padding(.vertical, .micro)
    }
}

extension BaseListItem {
    func trailingIcon(_ icon: Icon, onTap: @escaping () -> Void) -> some View {
        var view = self
        view.trailingIcon = icon
        view.trailingIconAction = onTap
        return view
    }
}

struct BaseListItem_Previews: PreviewProvider {
    static var previews: some View {
        BaseListItem(title: "Title", caption: "caption")
    }
}
