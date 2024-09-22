//
//  DashboardBottomPanel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/09/2024.
//

import Resources
import SwiftUI
import Widgets

struct DashboardBottomPanel: View {
    let isTodaySelected: Bool
    let showDatePicker: () -> Void
    let selectTodaysDate: () -> Void
    let showTeachersList: () -> Void
    let showPavilionsList: () -> Void

    var body: some View {
        HStack(spacing: .large) {
            Menu {
                Button(L10n.teachersListTitle, icon: .teachersList, action: showTeachersList)
                Button(L10n.pavilionsListTitle, icon: .pavilionsList, action: showPavilionsList)
            } label: {
                Button("More", action: {})
                    .buttonStyle(.expandableButtonStyle(icon: .more))
            }

            Button(L10n.calendar, action: showDatePicker)
                .buttonStyle(.expandableButtonStyle(icon: .calendar, fillMaxWidth: true, isExpanded: true))

            Button(L10n.today, action: selectTodaysDate)
                .buttonStyle(.expandableButtonStyle(icon: selectTodaysDateButtonIcon, isExpanded: !isTodaySelected))
                .disabled(isTodaySelected)
        }
        .padding(.horizontal, .large)
        .animation(.easeInOut(duration: 0.2), value: isTodaySelected)
    }

    private var selectTodaysDateButtonIcon: Icon {
        isTodaySelected ? .recordCircle : .chevronForwardCircle
    }
}

#Preview {
    DashboardBottomPanel(isTodaySelected: true, showDatePicker: {}, selectTodaysDate: {}, showTeachersList: {}, showPavilionsList: {})
}
