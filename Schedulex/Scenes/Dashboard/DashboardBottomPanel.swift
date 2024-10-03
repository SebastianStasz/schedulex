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
    let selectDefaultDate: () -> Void
    let showTeachersList: () -> Void
    let showPavilionsList: () -> Void
    let showCampusMap: () -> Void

    var body: some View {
        HStack(spacing: .large) {
            Menu {
                Button(L10n.teachersListTitle, icon: .teachersList, action: showTeachersList)
                Button(L10n.pavilionsListTitle, icon: .pavilionsList, action: showPavilionsList)
                if #available(iOS 17.0, *) {
                    Button("Campus map", icon: .pavilionsList, action: showCampusMap)
                }
            } label: {
                Button(L10n.more, action: {})
                    .buttonStyle(.expandableButtonStyle(icon: .more))
            }

            Button(L10n.calendar, action: showDatePicker)
                .buttonStyle(.expandableButtonStyle(icon: .calendar, fillMaxWidth: true, isExpanded: true))

            ResetExpandableButton(title: L10n.today, isDefaultValueSelected: isDefaultDateSelected, action: selectDefaultDate)
        }
        .padding(.horizontal, .large)
        .padding(.bottom, UIDevice.current.hasNotch ? 0 : .small)
        .animation(.easeInOut(duration: 0.2), value: isDefaultDateSelected)
    }
}

#Preview {
    DashboardBottomPanel(isDefaultDateSelected: true, showDatePicker: {}, selectDefaultDate: {}, showTeachersList: {}, showPavilionsList: {}, showCampusMap: {})
}
