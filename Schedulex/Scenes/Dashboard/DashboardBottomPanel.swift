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
    let isDefaultDateSelected: Bool
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
                Button(L10n.more, action: {})
                    .buttonStyle(.expandableButtonStyle(icon: .more))
            }

            Button(L10n.calendar, action: showDatePicker)
                .buttonStyle(.expandableButtonStyle(icon: .calendar, fillMaxWidth: true, isExpanded: true))

            Button(L10n.today, action: selectTodaysDate)
                .buttonStyle(.expandableButtonStyle(icon: dateSelectionButtonIcon, isExpanded: !isDefaultDateSelected))
                .disabled(isDefaultDateSelected)
        }
        .padding(.horizontal, .large)
        .animation(.easeInOut(duration: 0.2), value: isDefaultDateSelected)
    }

    private var dateSelectionButtonIcon: Icon {
        isDefaultDateSelected ? .recordCircle : .chevronForwardCircle
    }
}

#Preview {
    DashboardBottomPanel(isDefaultDateSelected: true, showDatePicker: {}, selectTodaysDate: {}, showTeachersList: {}, showPavilionsList: {})
}
