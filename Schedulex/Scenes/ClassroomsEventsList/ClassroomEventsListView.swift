//
//  ClassroomEventsListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 10/06/2024.
//

import SwiftUI
import SchedulexViewModel

struct ClassroomEventsListView: RootView {
    @ObservedObject var store: ClassroomEventsListStore

    var rootBody: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

final class ClassroomEventsListViewController: SwiftUIViewController<ClassroomsListViewModel, ClassroomsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
    }
}

#Preview {
    ClassroomEventsListView(store: ClassroomEventsListStore())
}
