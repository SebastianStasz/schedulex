//
//  DayPickerItemView.swift
//  Widgets
//
//  Created by Sebastian Staszczyk on 19/09/2023.
//

import SwiftUI

struct DayPickerItemView: View {
    let item: DayPickerItem
    let isSelected: Bool
    let isToday: Bool

    var body: some View {
        VStack(spacing: .medium) {
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
            
            HStack(spacing: 5) {
                ForEach(item.circleColors.prefix(4), id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 6, height: 6)
                }
            }
        }
        .frame(maxHeight: .infinity ,alignment: .top)
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(borderColor, lineWidth: isToday ? 2 : 1)
            .opacity(isSelected ? 0 : 1)
    }

    private var weekday: String {
        item.date.formatted(.dateTime.weekday(.abbreviated))
    }

    private var dayNumber: String {
        item.date.formatted(.dateTime.day(.twoDigits))
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
}

#Preview {
    VStack(spacing: .large) {
        DayPickerItemView(item: DayPickerItem(date: .now), isSelected: false, isToday: false)
        DayPickerItemView(item: DayPickerItem(date: .now), isSelected: false, isToday: true)
        DayPickerItemView(item: DayPickerItem(date: .now), isSelected: true, isToday: false)
        DayPickerItemView(item: DayPickerItem(date: .now), isSelected: true, isToday: true)
    }
    .frame(width: 65)
}
