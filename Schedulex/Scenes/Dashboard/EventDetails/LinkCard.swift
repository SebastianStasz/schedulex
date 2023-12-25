//
//  LinkCard.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 25/12/2023.
//

import SwiftUI
import Widgets

struct LinkCard: View {
    let title: String
    let subtitle: String
    let image: Image
    let action: () -> Void

    var body: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .leading, spacing: .micro) {
                Text(title, style: .bodyMedium)
                    .foregroundStyle(.textPrimary)

                Text(subtitle, style: .footnote)
                    .foregroundStyle(.grayShade1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)

            image
                .resizable()
                .scaledToFit()
                .frame(height: 24)
                .foregroundStyle(.grayShade1)
        }
        .padding(.large)
        .background(.backgroundTertiary)
        .cornerRadius(.large)
        .onTapGesture(perform: action)
    }
}

extension LinkCard {
    init(title: String, subtitle: String, icon: Icon, action: @escaping () -> Void) {
        self.init(title: title, subtitle: subtitle, image: Image.icon(icon), action: action)
    }
}

#Preview {
    LinkCard(title: "e-wizytówka", subtitle: "prof. UEK dr hab. Grażyna Paliwoda-Pękosz", icon: .contactCard, action: {})
        .padding(.large)
}
