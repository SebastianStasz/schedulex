//
//  FacultyGroupListItemView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/08/2023.
//

import Domain
import SwiftUI

struct FacultyGroupListItemView: View {
    let event: Event
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name ?? "")

                Text(event.teacher ?? "")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let date = event.startDate {
                Text(date.formatted(date: .omitted, time: .shortened))
            }
        }
        .padding(.vertical, 6)
    }
}

struct FacultyGroupListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupListItemView(event: .sample)
    }
}
