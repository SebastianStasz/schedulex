//
//  FacultyGroupClassListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import Resources
import SwiftUI
import Widgets

struct EditableFacultyGroupClass: Equatable, Codable {
    let facultyGroupName: String
    let facultyGroupClass: FacultyGroupClass

    func toFacultyGroupClass() -> FacultyGroupClass {
        FacultyGroupClass(name: facultyGroupClass.name, type: facultyGroupClass.type, teacher: facultyGroupClass.teacher)
    }
}

extension FacultyGroupClass {
    func toEditableFacultyGroupClass(facultyGroupName: String) -> EditableFacultyGroupClass {
        EditableFacultyGroupClass(facultyGroupName: facultyGroupName, facultyGroupClass: self)
    }
}

struct FacultyGroupClassListView: View {
    @AppStorage("hiddenFacultyGroupsClasses") private var allHiddenClasses: [EditableFacultyGroupClass] = []
    let facultyGroupName: String
    let classes: [FacultyGroupClass]
    let viewType: FacultyGroupDetailsView.ViewType

    var body: some View {
        Group {
            if viewType == .preview {
                BaseList(classes, id: \.self) { FacultyGroupClassListItem(facultyGroupClass: $0, isSelected: true, action: nil) }
            } else {
                SectionedList(sections, pinnedHeaders: true) { sectionIndex, groupClass in
                    FacultyGroupClassListItem(facultyGroupClass: groupClass, isSelected: sectionIndex == 0) {
                        if sectionIndex == 0 {
                            hideClass(groupClass)
                        } else {
                            unhideClass(groupClass)
                        }
                    }
                }
                .animation(.easeInOut, value: allHiddenClasses)
            }
        }
        .navigationTitle(L10n.classes)
        .baseListStyle()
    }

    private var sections: [ListSection<FacultyGroupClass>] {
        [ListSection(title: L10n.visible, items: visibleClasses),
         ListSection(title: L10n.hidden, items: hiddenClasses)]
    }

    private var visibleClasses: [FacultyGroupClass] {
        classes.filter { !hiddenClasses.contains($0) }
    }

    private var hiddenClasses: [FacultyGroupClass] {
        allHiddenClasses
            .filter { $0.facultyGroupName == facultyGroupName }
            .map { $0.toFacultyGroupClass() }
    }

    private func hideClass(_ groupClass: FacultyGroupClass) {
        let groupClass = groupClass.toEditableFacultyGroupClass(facultyGroupName: facultyGroupName)
        allHiddenClasses.append(groupClass)
    }

    private func unhideClass(_ groupClass: FacultyGroupClass) {
        let groupClass = groupClass.toEditableFacultyGroupClass(facultyGroupName: facultyGroupName)
        allHiddenClasses.removeAll { $0 == groupClass }
    }
}

#Preview {
    FacultyGroupClassListView(facultyGroupName: "ZZ", classes: [], viewType: .preview)
}
