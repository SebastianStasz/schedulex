//
//  OpenTeamsButton.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 29/09/2024.
//

import Resources
import SwiftUI

public struct OpenTeamsButton: View {
    @Environment(\.openURL) private var openURL
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        HStack(spacing: .small) {
            Image.teamsLogo
                .resizable()
                .scaledToFit()
                .frame(height: 16)

            Text(L10n.dashboardOpenTeams, style: .footnote)
                .foregroundStyle(Color.white)
        }
        .padding(.small)
        .background(Color.black.opacity(0.5))
        .cornerRadius(.medium)
        .onTapGesture { openURL(url) }
    }
}

#Preview {
    OpenTeamsButton(url: URL(string: "www.google.com")!)
}
