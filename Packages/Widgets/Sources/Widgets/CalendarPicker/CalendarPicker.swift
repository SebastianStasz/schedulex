//
//  CalendarPicker.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 10/11/2023.
//

import SwiftUI

public struct CalendarPicker: View {
    private let items: [DayPickerItem]
    @State private var selectedMonth: YearAndMonth?
    @Binding private var selectedDate: Date

    public init(items: [DayPickerItem], selectedDate: Binding<Date>) {
        self.items = items
        _selectedDate = selectedDate
        months = Dictionary(grouping: items, by: {
            YearAndMonth(year: Calendar.current.component(.year, from: $0.date),
                         month: Calendar.current.component(.month, from: $0.date))
        })
        .map { CalendarPickerMonth(yearAndMonth: $0.key, dayPickerItems: $0.value) }
        .sorted { $0.yearAndMonth.date < $1.yearAndMonth.date }
    }

    private let months: [CalendarPickerMonth]

    private var rows: [GridItem] {
        Array(repeating: GridItem(spacing: .small), count: 7)
    }

    public var body: some View {
        VStack(spacing: .small) {
            //            HStack(spacing: 0) {
            //                if let selectedMonth {
            //                    Text(selectedMonth.date.formatted(.dateTime.month(.wide).year()), style: .titleSmall)
            //                }
            //
            //                Spacer()
            //            }
            //            GeometryReader { proxy in
            //            LazyVGrid(columns: rows, spacing: 0) {


            LazyVGrid(columns: rows) {
                ForEach(Locale.Weekday.allCases) {
                    Text($0.rawValue, style: .footnote)
                        .textCase(.uppercase)
                        .fontWeight(.semibold)
                        .foregroundStyle(.grayShade1)
                        .frame(maxWidth: .infinity)
                }
            }

            TabView(selection: $selectedMonth) {
                ForEach(months) { month in
                    LazyVGrid(columns: rows, spacing: .small) {
                        ForEach(0..<month.daysOffset, id: \.self) { _ in
                            Color.clear
                        }

                        ForEach(month.getDays(), id: \.self) { item in
                            let day = item.date.formatted(.dateTime.day())
                            let isSelected = item.date.isSameDay(as: selectedDate)
                            let isToday = item.date.isSameDay(as: .now)

                            CalendarPickerItemView(day: day, isToday: isToday, isSelected: isSelected)
                                .onTapGesture { selectedDate = item.date }
                                .disabled(!item.isSelectable)
                        }
                    }
                    .tag(Optional(month.yearAndMonth))
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(nil)
        }
        .onChange(of: selectedDate) { selectedMonth = $0.toYearAndMonth() }
        .onAppear { selectedMonth = selectedDate.toYearAndMonth() }
    }
}

#Preview {
    let startDate: Date = .now
    let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
    var dates: [Date] = []
    var date = startDate
    while date < endDate {
        dates.append(date)
        date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    let items = dates.map { DayPickerItem(date: $0, isSelectable: true) }
    return CalendarPicker(items: items, selectedDate: .constant(.now))
}
