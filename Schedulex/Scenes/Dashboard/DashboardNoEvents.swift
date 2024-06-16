//
//  DashboardNoEvents.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 09/03/2024.
//

import Resources
import SwiftUI
import Widgets

struct DashboardNoEvents: View {
    let date: Date

    var body: some View {
        VStack(spacing: .small) {
            Text(message, style: .body)
                .foregroundStyle(.grayShade1)

            SwiftUI.Text(emoji)
                .font(.title)
        }
    }

    private var message: String {
        isWeekend ? L10n.noEventsWeekendMessage : L10n.noEventsMessage
    }

    private var emoji: String {
        emojis.randomElement() ?? "❤️"
    }

    private var isWeekend: Bool {
        NSCalendar.current.isDateInWeekend(date)
    }

    private var emojis: [String] {
        ["😊", "😻", "👑", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐥", "🪿", "🦆", "🐴", "🐝", "🦄", "🐛", "🦋", "🐌", "🐞", "🐢", "🐙", "🦕", "🦖", "🪼", "🐡", "🐳", "🐅", "🦒", "🐏", "🦙", "🐐", "🐩", "🐈", "🦩", "🐁", "🐿️", "🦔", "🌵", "🌴", "🍀", "🍄", "🪸", "🌹", "🌸", "🌻", "🌈", "☀️", "💧", "🍎", "🍌", "🍓", "🫐", "🥝", "🍅", "🥦", "🍆", "🍍", "🥥", "🧄", "🧅", "🍔", "🥪", "🥙", "🥗", "🍭", "🍿", "🍪", "⚽️", "🏀", "🏈", "🥎", "🏓", "🏸", "⛳️", "🪁", "🛝", "🛹", "🛼", "🏋️", "🪂", "🏄‍♀️", "🧘‍♀️", "🚣", "🎨", "🎧", "🎹", "🎺", "🎻", "🥁", "🚜", "🛞", "🚂", "🚀", "🏝️", "🏔️", "🏕️", "📀", "🧬", "🎁", "❤️", "🧡", "💛", "💚", "🩵", "💙", "💜", "🥹", "🎉", "🥳", "🍾", "🪩", "🍻", "🍺", "🍹", "🍸", "😎", "💃", "🕺", "🎸", "🎳", "🎮", "🎢", "💤", "😴", "🛌", "🛍️", "😍", "🤩"]
    }
}

#Preview {
    DashboardNoEvents(date: .now)
}
