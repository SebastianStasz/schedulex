//
//  BaseListItem.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import SwiftUI

struct BaseListItem: View {
    let title: String
    let caption: String?

    init(title: String, caption: String? = nil) {
        self.title = title
        self.caption = caption
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)

            if let caption {
                Text(caption)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 6)
    }
}

struct BaseListItem_Previews: PreviewProvider {
    static var previews: some View {
        BaseListItem(title: "Title", caption: "caption")
    }
}
