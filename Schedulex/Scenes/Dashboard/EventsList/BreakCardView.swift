//
//  BreakCardView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 24/12/2023.
//

import Resources
import SwiftUI
import Widgets

struct BreakCardView: View {
    let breakTimeComponents: DateComponents

    var body: some View {
        Text(breakTimeDescription, style: .footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.large)
            .foregroundStyle(.white)
            .background(.accentPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var breakTimeDescription: String {
        guard let time = Calendar.current.date(from: breakTimeComponents),
              let hour = breakTimeComponents.hour,
              let minute = breakTimeComponents.minute
        else { return L10n.breakCardTitle }
        return hour == 0 ? descriptionForMinutes(minute) : descriptionForTime(time)
    }

    private func descriptionForMinutes(_ minute: Int) -> String {
        "\(L10n.breakCardTitle) \(minute) \(L10n.minutesSuffix)"
    }

    private func descriptionForTime(_ time: Date) -> String {
        "\(L10n.breakCardTitle) \(time.formatted(style: .timeBetween)) \(L10n.breakCardTimeSuffix)"
    }
}

#Preview {
    VStack(spacing: .large) {
        BreakCardView(breakTimeComponents: DateComponents(hour: 1, minute: 45))
        BreakCardView(breakTimeComponents: DateComponents(hour: 0, minute: 45))
    }
    .padding(.large)
}
