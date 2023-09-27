//
//  DashboardView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import SwiftUI
import Widgets
import SchedulexFirebase

struct DashboardView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @StateObject private var viewModel = DashboardViewModel()
    @State private var service = FirestoreService()
    @State private var isDatePickerPresented = false
    @State private var isSchedulesSheetPresented = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if let startDate = viewModel.startDate, let endDate = viewModel.endDate {
                    LazyVStack {
                        DayPickerView(startDate: startDate, endDate: endDate, shouldScrollToDay: isDatePickerPresented, selection: $viewModel.selectedDate)
                    }
                    .padding(.top, .xlarge)
                    .padding(.bottom, .medium)
                    .background(.backgroundSecondary)

                    Rectangle()
                        .fill(.grayShade1)
                        .frame(height: 1)
                        .opacity(0.15)

                    ScrollView {
                        VStack(spacing: .medium) {
                            ForEach(viewModel.selectedDateEvents, id: \.self) { event in
                                EventCardView(event: event)
                            }
                        }
                        .padding(.top, .large)
                        .padding(.horizontal, .medium)
                        .background(.backgroundPrimary)
                    }
                }
            }
            .overlay {
                if viewModel.selectedDateEvents.isEmpty {
                    Text("No events here", style: .body)
                        .foregroundStyle(.grayShade1)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack(spacing: 0) {
                        TextButton("Schedules") { isSchedulesSheetPresented = true }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextButton("Today") { viewModel.selectedDate = .now }
                            .frame(maxWidth: .infinity)
                        TextButton("Calendar") { isDatePickerPresented = true }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal, .micro)
                }
            }
            .sheet(isPresented: $isDatePickerPresented) { datePicker }
            .sheet(isPresented: $isSchedulesSheetPresented) { ObservedFacultyGroupsView(service: service) }
        }

        .doubleNavigationTitle(title: viewModel.title, subtitle: viewModel.subtitle)
        .toolbar(.hidden)
        .task {
            Task {
                try await viewModel.fetchEvents(for: subscribedGroups)
            }
        }
//        .onChange(of: subscribedGroups) {
//            viewModel.fetchEvents(for: $0)
//        }
    }

    @ViewBuilder
    private var datePicker: some View {
        if let startDate = viewModel.startDate, let endDate = viewModel.endDate {
            DatePicker("Select date", selection: $viewModel.selectedDate, in: startDate...endDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(.horizontal, .medium)
                .presentationDetents([.height(380)])
                .presentationDragIndicator(.visible)
                .tint(Color.accentPrimary)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
