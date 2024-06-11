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
        FacultyGroupEventListView(title: store.classroomName, color: .blue, events: store.events)
            .baseListStyle(isLoading: store.isLoading.value)
    }
}

final class ClassroomEventsListViewController: SwiftUIViewController<ClassroomEventsListViewModel, ClassroomEventsListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.classroom.name
    }
}

#Preview {
    ClassroomEventsListView(store: ClassroomEventsListStore(classroomName: "Classroom name"))
}
