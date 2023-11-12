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
    let circleColors: [Color]

    var body: some View {
        VStack(spacing: .micro) {
            SwiftUI.Text(day)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(dayNumberColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .overlay(border)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .aspectRatio(1, contentMode: .fit)
                .contentShape(Rectangle())

            HStack(spacing: 5) {
                if circleColors.isEmpty {
                    Circle()
                        .frame(width: 5, height: 5)
                        .opacity(0)
                } else {
                    ForEach(circleColors.prefix(4), id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 5, height: 5)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity ,alignment: .top)
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
    VStack(spacing: 0) {
        CalendarPickerItemView(day: "12", isToday: true, isSelected: true, circleColors: [.blue])
        CalendarPickerItemView(day: "12", isToday: false, isSelected: true, circleColors: [])
        CalendarPickerItemView(day: "12", isToday: true, isSelected: false, circleColors: [])
        CalendarPickerItemView(day: "12", isToday: false, isSelected: false, circleColors: [.blue])
        CalendarPickerItemView(day: "12", isToday: false, isSelected: false, circleColors: [])
            .disabled(true)
    }
    .frame(width: 40)
}
