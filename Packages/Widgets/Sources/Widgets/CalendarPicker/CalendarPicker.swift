//
//  CalendarPicker.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 10/11/2023.
//

import Resources
import SwiftUI

public struct CalendarPicker: View {
    private let items: [DayPickerItem]
    private let selectTodaysDate: () -> Void
    @State private var selectedMonth = YearAndMonth(year: 1, month: 1)
    @Binding private var selectedDate: Date

    public init(items: [DayPickerItem], selectedDate: Binding<Date>, selectTodaysDate: @escaping () -> Void) {
        self.items = items
        self.selectTodaysDate = selectTodaysDate
        _selectedMonth.wrappedValue = selectedDate.wrappedValue.toYearAndMonth()
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
        Array(repeating: GridItem(spacing: 6), count: 7)
    }

    public var body: some View {
        VStack(spacing: .large) {
            HStack(spacing: 0) {
                SwiftUI.Text(selectedMonth.date.formatted(.dateTime.month(.wide).year()))
                    .font(.headline)

                Spacer()

                TextButton(L10n.today, action: onTodaysDateClick)
            }
            .padding(.horizontal, .large)

            VStack(spacing: .small) {
                LazyVGrid(columns: rows) {
                    ForEach(Weekday.allCases, id: \.self) {
                        Text($0.shortSymbol, style: .footnote)
                            .fontWeight(.medium)
                            .textCase(.uppercase)
                            .foregroundStyle(.grayShade1)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, .large)

                TabView(selection: $selectedMonth) {
                    ForEach(months) { month in
                        LazyVGrid(columns: rows, spacing: .micro) {
                            ForEach(0 ..< month.daysOffset, id: \.self) { _ in
                                Color.clear
                            }

                            ForEach(month.getDays(), id: \.self) { item in
                                let day = item.date.formatted(.dateTime.day())
                                let isSelected = item.date.isSameDay(as: selectedDate)
                                let isToday = item.date.isSameDay(as: .now)

                                CalendarPickerItemView(day: day, isToday: isToday, isSelected: isSelected, circleColors: item.circleColors)
                                    .onTapGesture { selectedDate = item.date }
                                    .disabled(!item.isSelectable)
                            }
                        }
                        .tag(month.yearAndMonth)
                        .padding(.horizontal, .large)
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(nil)
            }
        }
        .onAppear { selectedMonth = selectedDate.toYearAndMonth() }
    }

    private func onTodaysDateClick() {
        selectTodaysDate()
        selectedMonth = selectedDate.toYearAndMonth()
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
    let colors: [Color?] = [.blue, nil]
    let items = dates.map { DayPickerItem(date: $0, circleColors: [.blue], isSelectable: true) }
    return CalendarPicker(items: items, selectedDate: .constant(.now), selectTodaysDate: {})
}
