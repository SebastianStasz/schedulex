//
//  FacultyGroupListItemView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/08/2023.
//

import Domain
import SwiftUI

extension Date {
    func toTime() -> String {
        formatted(date: .omitted, time: .shortened)
    }
}

struct FacultyGroupListItemView: View {
    let event: Event
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    if let startDate = event.startDate, let endDate = event.endDate {
                        Text("\(startDate.toTime()) - \(endDate.toTime())")
                            .font(.caption)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(event.name ?? "")

                        if let place = event.place {
                            Text(place)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 10)

            Rectangle()
                .frame(height: 1)
                .opacity(0.1)
        }
    }
}

struct FacultyGroupListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyGroupListItemView(event: .sample)
    }
}
