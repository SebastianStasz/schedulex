//
//  FacultyGroupClassesListView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 02/10/2023.
//

import Domain
import SwiftUI
import Widgets

struct FacultyGroupClassesListView: View {
    let classes: [FacultyGroupClass]
    
    var body: some View {
        List(classes, id: \.self) { groupClass in
            VStack(alignment: .leading, spacing: .small) {
                Text(groupClass.name, style: .body)

                VStack(alignment: .leading, spacing: .micro) {
                    if let teacher = groupClass.teacher {
                        Text(teacher, style: .note)
                            .foregroundColor(.gray)
                    }

                    Text(groupClass.type, style: .note)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, .micro)
        }
        .navigationTitle("Classes")
        .baseListStyle()
    }
}

#Preview {
    FacultyGroupClassesListView(classes: [])
}
