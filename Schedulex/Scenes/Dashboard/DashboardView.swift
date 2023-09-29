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

                    separator()

                    ScrollView {
                        VStack(spacing: .medium) {
                            ForEach(viewModel.selectedDateEvents, id: \.self) { event in
                                EventCardView(event: event)
                            }
                        }
                        .padding(.vertical, .large)
                        .padding(.horizontal, .medium)
                        .background(.backgroundPrimary)
                    }
                }
            }
            .overlay { loadingIndicatorOrEmptyState }
            .toolbar { toolbarContent }
        }
        .toolbar(.hidden)
        .doubleNavigationTitle(title: viewModel.title, subtitle: viewModel.subtitle)
        .sheet(isPresented: $isSchedulesSheetPresented) { ObservedFacultyGroupsView(service: service) }
        .sheet(isPresented: $isDatePickerPresented) { datePicker }
        .onChange(of: subscribedGroups) { _ in fetchEvents() }
        .task { fetchEvents() }
    }

    private func separator() -> some View {
        Rectangle()
            .fill(.grayShade1)
            .frame(height: 1)
            .opacity(0.1)
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

    @ViewBuilder
    private var loadingIndicatorOrEmptyState: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if viewModel.selectedDateEvents.isEmpty {
            Text("No events here", style: .body)
                .foregroundStyle(.grayShade1)
        }
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack(spacing: 0) {
                TextButton("Schedules") { isSchedulesSheetPresented = true }
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextButton("Today") { viewModel.selectedDate = .now }
                    .frame(maxWidth: .infinity)
                TextButton("Calendar", action: showDatePicker)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, .micro)
        }
    }

    private func showDatePicker() {
        guard !viewModel.isLoading && !viewModel.selectedDateEvents.isEmpty else { return }
        isDatePickerPresented = true
    }

    private func fetchEvents() {
        Task { try await viewModel.fetchEvents(for: subscribedGroups) }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
