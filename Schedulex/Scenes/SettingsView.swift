//
//  SettingsView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/11/2023.
//

import SwiftUI
import Widgets
import Resources

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Content")
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .toolbar { toolbarContent }
    }
    
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            TextButton("") {  }
        }
    }
}

#Preview {
    SettingsView()
}
