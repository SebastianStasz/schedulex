//
//  DayPickerView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

public struct DayPickerView: View {
    let dates: [Date]
    @Binding var selectedDate: Date

    public init(startDate: Date, endDate: Date, selection: Binding<Date>) {
        var dates: [Date] = []
        var date = startDate
        while date <= endDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        self.dates = dates
        _selectedDate = selection
    }

    public var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: .large) {
                ForEach(dates, id: \.self) { date in
                    DayPickerItemView(date: date, isSelected: date.isSameDay(as: selectedDate))
                        .frame(width: dayPickerItemWidth)
                        .onTapGesture { selectedDate = date }
                }
            }
            .padding(.horizontal, .medium)
        }
        .scrollIndicators(.hidden)
    }

    private var dayPickerItemWidth: CGFloat {
        (UIScreen.main.bounds.size.width - (2 * .medium) - (4 * .large)) / 5
    }
}

#Preview {
    let endDate = Calendar.current.date(byAdding: .day, value: 10, to: .now)!
    let selectedDate = Calendar.current.date(byAdding: .day, value: 2, to: .now)!
    return DayPickerView(startDate: .now, endDate: endDate, selection: .constant(selectedDate))
}
