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

    private let items: [DayPickerItem]
    private let isDatePickerPresented: Bool
    @Binding private var selectedDate: Date
    @Binding private var shouldScrollToDay: Bool

    public init(items: [DayPickerItem], isDatePickerPresented: Bool = false, shouldScrollToDay: Binding<Bool>, selection: Binding<Date>) {
        self.items = items
        self.isDatePickerPresented = isDatePickerPresented
        _shouldScrollToDay = shouldScrollToDay
        _selectedDate = selection
    }

    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: .large) {
                    ForEach(items, id: \.self) { item in
                        DayPickerItemView(item: item, isSelected: item.date.isSameDay(as: selectedDate))
                            .frame(width: dayPickerItemWidth)
                            .contentShape(Rectangle())
                            .onTapGesture { selectedDate = item.date }
                            .id(item.date.formatted(style: .dateLong))
                            .onChange(of: selectedDate) { date in
                                if shouldScrollToDay || isDatePickerPresented {
                                    withAnimation(.easeInOut) {
                                        proxy.scrollTo(date.formatted(style: .dateLong), anchor: .center)
                                        shouldScrollToDay = false
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
            .onChange(of: items) { _ in
                listId += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    proxy.scrollTo(selectedDate.formatted(style: .dateLong), anchor: .center)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    let endDate = Calendar.current.date(byAdding: .day, value: 10, to: .now)!
//    let selectedDate = Calendar.current.date(byAdding: .day, value: 2, to: .now)!
//    return DayPickerView(startDate: .now, endDate: endDate, shouldScrollToDay: .constant(false), selection: .constant(selectedDate))
//}
