//
//  SchoolView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import SwiftUI

struct SchoolView: RootView {
    @ObservedObject var store: SchoolStore

    var rootBody: some View {
        List {
            ForEach(store.faculties, id: \.self) { faculty in
                BaseListItem(title: faculty.name, caption: "\(faculty.numberOfGroups) groups")
            }
            ForEach(store.facultyGroups, id: \.self) { group in
                BaseListItem(title: group.name, caption: "\(group.numberOfEvents) events")
                Text("test")
            }
        }
        .navigationTitle("UEK")
        .searchable(text: $store.searchText, prompt: "Faculty or group")
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolView(store: SchoolStore())
    }
}
