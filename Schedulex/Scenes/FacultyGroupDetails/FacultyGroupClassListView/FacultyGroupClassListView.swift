//
//  FacultyGroupClassListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Resources
import SwiftUI
import Widgets
import SchedulexViewModel
import SchedulexCore

struct FacultyGroupClassListView: RootView {
    @ObservedObject var store: FacultyGroupClassListStore

    var rootBody: some View {
        Group {
            if store.viewType == .preview {
                BaseList(store.classes, id: \.self) { FacultyGroupClassListItem(facultyGroupClass: $0.facultyGroupClass, isSelected: true, action: nil) }
            } else {
                SectionedList(sections, pinnedHeaders: true) { sectionIndex, groupClass in
                    FacultyGroupClassListItem(facultyGroupClass: groupClass.facultyGroupClass, isSelected: sectionIndex == 0) {
                        if sectionIndex == 0 {
                            store.hideFacultyGroupClass.send(groupClass)
                        } else {
                            store.unhideFacultyGroupClass.send(groupClass)
                        }
                    }
                }
                .animation(.easeInOut, value: store.hiddenClasses)
            }
        }
    }

    private var sections: [ListSection<EditableFacultyGroupClass>] {
        [ListSection(title: L10n.visible, items: store.visibleClasses),
         ListSection(title: L10n.hidden, items: store.hiddenClasses)]
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
