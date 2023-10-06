//
//  DayPickerView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

public struct DayPickerView: View {
    @State private var listId = 0
    private let dayPickerItemWidth = (UIScreen.main.bounds.size.width - (2 * .medium) - (4 * .large)) / 5

    let dates: [Date]
    let shouldScrollToDay: Bool
    @Binding var selectedDate: Date

    public init(startDate: Date, endDate: Date, shouldScrollToDay: Bool = false, selection: Binding<Date>) {
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)!
        var dates: [Date] = []
        var date = startDate
        while date < endDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        self.dates = dates
        self.shouldScrollToDay = shouldScrollToDay
        _selectedDate = selection
    }

    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: .large) {
                    ForEach(dates, id: \.self) { date in
                        DayPickerItemView(date: date, isSelected: date.isSameDay(as: selectedDate))
                            .frame(width: dayPickerItemWidth)
                            .contentShape(Rectangle())
                            .onTapGesture { selectedDate = date }
                            .id(date.formatted(style: .dateLong))
                            .onChange(of: selectedDate) { date in
                                if shouldScrollToDay {
                                    withAnimation(.easeInOut) {
                                        proxy.scrollTo(date.formatted(style: .dateLong), anchor: .center)
                                    }
                                }
                            }
                    }
                }
                .padding(.horizontal, .medium)
            }
            .id(listId)
            .onAppear {
                proxy.scrollTo(selectedDate.formatted(style: .dateLong), anchor: .center)
            }
        }
        .scrollIndicators(.hidden)
        .onChange(of: dates) { _ in listId += 1 }
    }
}

#Preview {
    let endDate = Calendar.current.date(byAdding: .day, value: 10, to: .now)!
    let selectedDate = Calendar.current.date(byAdding: .day, value: 2, to: .now)!
    return DayPickerView(startDate: .now, endDate: endDate, selection: .constant(selectedDate))
}
