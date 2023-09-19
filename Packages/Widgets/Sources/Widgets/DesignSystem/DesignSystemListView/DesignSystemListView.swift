//
//  DesignSystemListView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

struct DesignSystemListView: View {
    var body: some View {
        NavigationStack {
            List(DesignSystemListSection.allCases, id: \.self) { section in
                Section(section.name) {
                    ForEach(section.items, id: \.self) { item in
                        NavigationLink(item.name) { item.destination }
                    }
                }
            }
            .navigationTitle("Design system")
        }
    }
}

#Preview {
    DesignSystemListView()
}
