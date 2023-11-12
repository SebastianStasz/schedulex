//
//  CalendarPickerItemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 10/11/2023.
//

import SwiftUI

struct CalendarPickerItemView: View {
    @Environment(\.isEnabled) var isEnabled

    let day: String
    let isToday: Bool
    let isSelected: Bool

    var body: some View {
        Text(day, style: .bodyMedium)
            .foregroundStyle(dayNumberColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .overlay(border)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .aspectRatio(1, contentMode: .fit)
            .contentShape(Rectangle())
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.accentPrimary, lineWidth: 2)
            .opacity(isToday ? 1 : 0)
    }

    private var dayNumberColor: Color {
        guard isEnabled else {
            return .grayShade1
        }
        return isSelected ? .white : .textPrimary
    }

    private var backgroundColor: Color {
        isSelected ? .accentPrimary : .clear
    }
}

#Preview {
    VStack(spacing: .large) {
        CalendarPickerItemView(day: "1", isToday: true, isSelected: true)
        CalendarPickerItemView(day: "1", isToday: false, isSelected: true)
        CalendarPickerItemView(day: "1", isToday: true, isSelected: false)
        CalendarPickerItemView(day: "1", isToday: false, isSelected: false)
        CalendarPickerItemView(day: "1", isToday: false, isSelected: false)
            .disabled(true)
    }
    .frame(width: 40)
}
