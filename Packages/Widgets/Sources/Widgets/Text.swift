//
//  Text.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 21/09/2023.
//

import SwiftUI

public struct Text: View {
    private let text: String
    private let style: Typography

    public init(_ text: String, style: Typography) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        SwiftUI.Text(text)
            .font(style.font)
    }
}

#Preview {
    Text("Some text", style: .body)
}
