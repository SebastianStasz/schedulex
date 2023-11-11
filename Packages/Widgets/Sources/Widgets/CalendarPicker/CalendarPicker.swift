//
//  CalendarPicker.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 10/11/2023.
//

import SwiftUI

struct YearAndMonth: Hashable {
    let year: Int
    let month: Int

    var date: Date {
        let components = DateComponents(year: year, month: month)
        return Calendar.current.date(from: components)!
    }
}

extension Date {
    func toYearAndMonth() -> YearAndMonth {
        YearAndMonth(year: year, month: month)
    }
}

struct CalendarPickerMonth: Identifiable {
    let yearAndMonth: YearAndMonth
    let dayPickerItems: [DayPickerItem]

    var id: Date {
        yearAndMonth.date
    }
}


struct CalendarPickerItem {
    let days: [DayPickerItem]
    let yearAndMonth: YearAndMonth
}

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

    public var body: some View {
        VStack(spacing: .medium) {
            HStack(spacing: 0) {
                if let selectedMonth {
                    Text(selectedMonth.date.formatted(.dateTime.month(.wide).year()), style: .titleSmall)
                }

                Spacer()
            }

            GeometryReader { proxy in
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    headerGridRow()
                    
                    TabView(selection: $selectedMonth) {
                        ForEach(months) { month in
                            Grid(horizontalSpacing: .small, verticalSpacing: .small) {
                                ForEach(getDays(for: month), id: \.self) { dayPickerItems in
                                    GridRow {
                                        ForEach(dayPickerItems) { item in
                                            let day = item.date.formatted(.dateTime.day())
                                            let isToday = item.date.isSameDay(as: selectedDate)
                                            
                                            CalendarPickerItemView(day: day, isSelectable: item.isSelectable, isToday: isToday)
                                                .onTapGesture { selectedDate = item.date }
                                                .opacity(item.isVisible ? 1 : 0)
                                        }
                                    }
                                }
                            }
                            .tag(Optional(month.yearAndMonth))
                        }
                        .frame(height: (proxy.size.width / 7) * 5 + .small * 2)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .onChange(of: selectedDate) { selectedMonth = $0.toYearAndMonth() }
        .onAppear { selectedMonth = selectedDate.toYearAndMonth() }
    }

    private func headerGridRow() -> some View {
        GridRow {
            ForEach(Locale.Weekday.allCases) {
                Text($0.rawValue, style: .footnote)
                    .textCase(.uppercase)
                    .fontWeight(.semibold)
                    .foregroundStyle(.grayShade1)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func getDays(for month: CalendarPickerMonth) -> [[DayPickerItem]] {
        var days: [DayPickerItem] = month.dayPickerItems
        let yearAndMonth = month.yearAndMonth
        let firstDayWeekday = days.first!.date.startOfMonth.weekday
        let weekdayShift = firstDayWeekday - 2
        let emptyDaysCount = weekdayShift < 0 ? weekdayShift + 7 : weekdayShift

        if let firstDay = days.first?.date.day, firstDay > 1 {
            let nonSelectableDays: [DayPickerItem] = (1..<firstDay).compactMap {
                let components = DateComponents(year: yearAndMonth.year, month: yearAndMonth.month, day: $0)
                guard let date = Calendar.current.date(from: components) else { return nil }
                return DayPickerItem(date: date, isSelectable: false)
            }
            days.insert(contentsOf: nonSelectableDays, at: 0)
        }

        let emptyDays = (0..<emptyDaysCount).map { _ in DayPickerItem(date: .now, isVisible: false) }

        days.insert(contentsOf: emptyDays, at: 0)
        return days.chunked(into: 7)
    }

    private var numberOfDaysInCurrentMonth: Int {
        Calendar.current.range(of: .day, in: .month, for: selectedDate)!.count
    }
}

#Preview {
    CalendarPicker(items: [], selectedDate: .constant(.now))
}

extension Locale.Weekday: Identifiable, CaseIterable {
    public var id: String {
        rawValue
    }

    public static var allCases: [Locale.Weekday] {
        [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
}

extension Date {
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
