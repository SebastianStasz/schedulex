//
//  FacultyGroupClassListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Resources
import SchedulexCore
import SchedulexViewModel
import SwiftUI
import Widgets

struct FacultyGroupClassListView: RootView {
    @ObservedObject var store: FacultyGroupClassListStore

    var rootBody: some View {
        Group {
            if store.viewType == .preview {
                BaseList(store.classes, id: \.self) { FacultyGroupClassListItem(facultyGroupClass: $0.facultyGroupClass, isSelected: nil) }
            } else {
                SectionedList(sections, pinnedHeaders: true) { sectionIndex, groupClass in
                    FacultyGroupClassListItem(facultyGroupClass: groupClass.facultyGroupClass, isSelected: sectionIndex == 1)
                        .onTapGesture { hideOrShow(groupClass) }
                }
                .animation(.easeInOut, value: store.hiddenClasses)
            }
        }
    }

    private func hideOrShow(_ groupClass: EditableFacultyGroupClass) {
        if store.hiddenClasses.contains(groupClass) {
            store.unhideFacultyGroupClass.send(groupClass)
        } else {
            store.hideFacultyGroupClass.send(groupClass)
        }
    }

    private var sections: [ListSection<EditableFacultyGroupClass>] {
        [ListSection(title: L10n.hidden, items: store.hiddenClasses, emptyLabel: L10n.classesVisibilitySectionHiddenEmptyMessage),
         ListSection(title: L10n.visible, items: store.visibleClasses, emptyLabel: L10n.classesVisibilitySectionVisibleEmptyMessage)]
    }
}

final class FacultyGroupClassListViewController: SwiftUIViewController<FacultyGroupClassListViewModel, FacultyGroupClassListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.classes
    }
}

#Preview {
    FacultyGroupClassListView(store: FacultyGroupClassListStore(viewType: .preview))
}
