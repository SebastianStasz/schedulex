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
    
    var body: some View {
        List {
            Section("Widoczne") {
                ForEach(visibleClasses, id: \.self) { groupClass in
                    FacultyGroupClassListItem(facultyGroupClass: groupClass, isSelected: true) {
                        hideClass(groupClass)
                    }
                }
            }

            Section("Ukryte") {
                ForEach(hiddenClasses, id: \.self) { groupClass in
                    FacultyGroupClassListItem(facultyGroupClass: groupClass, isSelected: false) {
                        unhideClass(groupClass)
                    }
                }
            }
        }
        .navigationTitle(L10n.classes)
        .baseListStyle()
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
    FacultyGroupClassListView(facultyGroupName: "ZZ", classes: [])
}
