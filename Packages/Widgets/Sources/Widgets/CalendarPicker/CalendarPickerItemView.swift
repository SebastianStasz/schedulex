//
//  CalendarPickerItemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 10/11/2023.
//

import SwiftUI

struct CalendarPickerItemView: View {
    let day: String
    let isSelectable: Bool
    let isToday: Bool

    var body: some View {
        Text(day, style: .bodyMedium)
            .foregroundStyle(dayNumberColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .opacity(day == "0" ? 0 : 1)
            .contentShape(Rectangle())
            .allowsHitTesting(isSelectable)
    }

    private var dayNumberColor: Color {
        guard isSelectable else {
            return .grayShade1
        }
        return isToday ? .white : .textPrimary
    }

    private var backgroundColor: Color {
        isToday ? .accentPrimary : .clear
    }
}

#Preview {
    VStack(spacing: .large) {
        CalendarPickerItemView(day: "1", isSelectable: false, isToday: true)
        CalendarPickerItemView(day: "1", isSelectable: true, isToday: true)
        CalendarPickerItemView(day: "1", isSelectable: true, isToday: false)
    }
}
