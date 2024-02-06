//
//  DayPickerView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

public struct DayPickerView: View {
    private static let dayPickerItemWidth = (UIScreen.main.bounds.size.width - (2 * .medium) - (4 * .large)) / 5

    @Binding var items: [DayPickerItem]?
    @Binding private var selectedDate: Date

    public init(items: Binding<[DayPickerItem]?>, selection: Binding<Date>) {
        _items = items
        _selectedDate = selection
    }

    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: .large) {
                    ForEach(items ?? [], id: \.self.id) { item in
                        let isSelected = item.date.isSameDay(as: selectedDate)

                        DayPickerItemView(item: item, isSelected: isSelected, isToday: item.isToday)
                            .frame(width: Self.dayPickerItemWidth)
                            .contentShape(Rectangle())
                            .onTapGesture { selectedDate = item.date }
                            .id(item.id)
                    }
                }
                .padding(.horizontal, .medium)
            }
            .onAppear { scrollToSelectedDate(proxy: proxy, animate: false) }
            .onChange(of: selectedDate) { _ in scrollToSelectedDate(proxy: proxy, animate: true) }
            .scrollIndicators(.hidden)
        }
    }

    private func scrollToSelectedDate(proxy: ScrollViewProxy, animate: Bool) {
        if let item = items?.first(where: { $0.date.isSameDay(as: selectedDate) }) {
            if animate {
                withAnimation(.easeInOut) { proxy.scrollTo(item.id, anchor: .center) }
            } else {
                proxy.scrollTo(item.id, anchor: .center)
            }
        }
    }
}

//#Preview {
//    let endDate = Calendar.current.date(byAdding: .day, value: 10, to: .now)!
//    let selectedDate = Calendar.current.date(byAdding: .day, value: 2, to: .now)!
//    return DayPickerView(startDate: .now, endDate: endDate, shouldScrollToDay: .constant(false), selection: .constant(selectedDate))
//}
