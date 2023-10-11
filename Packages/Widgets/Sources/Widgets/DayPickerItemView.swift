//
//  DayPickerItemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

struct DayPickerItemView: View {
    let date: Date
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 2) {
            Text(weekday.uppercased(), style: .footnote)
                .foregroundStyle(dayTitleColor)

            Text(dayNumber, style: .titleSmall)
                .foregroundStyle(dayNumberColor)
        }
        .padding(.vertical, .medium)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .overlay(border)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(borderColor, lineWidth: isToday ? 2 : 1)
            .opacity(isSelected ? 0 : 1)
    }

    private var weekday: String {
        date.formatted(.dateTime.weekday(.abbreviated))
    }

    private var dayNumber: String {
        date.formatted(.dateTime.day(.twoDigits))
    }

    private var backgroundColor: Color {
        isSelected ? .accentPrimary : .clear
    }

    private var borderColor: Color {
        let color: Color = isToday ? .accentPrimary : .grayShade1
        return color.opacity(isToday ? 1 : 0.4)
    }

    private var dayTitleColor: Color {
        isSelected ? .white : .grayShade1
    }

    private var dayNumberColor: Color {
        isSelected ? .white : .textPrimary
    }

    private var isToday: Bool {
        Date.now.isSameDay(as: date)
    }
}

#Preview {
    VStack(spacing: .large) {
        DayPickerItemView(date: .now, isSelected: false)
        DayPickerItemView(date: .now, isSelected: true)
    }
    .frame(width: 65)
}
