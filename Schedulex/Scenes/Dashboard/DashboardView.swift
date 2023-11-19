//
//  DashboardView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 31/07/2023.
//

import Domain
import Resources
import SchedulexFirebase
import SwiftUI
import Widgets

struct DashboardView: View {
    @AppStorage("subscribedFacultyGroups") private var subscribedGroups: [FacultyGroup] = []
    @AppStorage("hiddenFacultyGroupsClasses") private var allHiddenClasses: [EditableFacultyGroupClass] = []
    @StateObject private var viewModel = DashboardViewModel()
    @EnvironmentObject private var service: FirestoreService
    @Environment(\.scenePhase) private var scenePhase

    @Binding var isFacultiesListPresented: Bool
    @State private var isDatePickerPresented = false
    @State private var isSchedulesSheetPresented = false

    var body: some View {
        VStack(spacing: 0) {
            if let items = viewModel.dayPickerItems {
                LazyVStack {
                    DayPickerView(items: items, isDatePickerPresented: $isDatePickerPresented, shouldScrollToDay: $viewModel.shouldScrollToDay, selection: $viewModel.selectedDate)
                }
                .padding(.top, .xlarge)
                .padding(.bottom, .medium)
                .background(.backgroundSecondary)

                separator()

                ScrollView {
                    VStack(spacing: .medium) {
                        ForEach(viewModel.selectedDateEvents, id: \.self) {
                            EventCardView(event: $0)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.vertical, .large)
                    .padding(.horizontal, .medium)
                    .background(.backgroundPrimary)
                }
                .gesture(dragGesture)
            } else {
                Rectangle()
                    .fill(Color.backgroundSecondary)
                    .frame(height: .medium)
                separator()
                Spacer()
            }
        }
        .overlay { loadingIndicatorOrEmptyState }
        .toolbar { toolbarContent }
        .doubleNavigationTitle(title: viewModel.title, subtitle: viewModel.subtitle)
        .sheet(isPresented: $isSchedulesSheetPresented) { ObservedFacultyGroupsView(service: service) }
        .sheet(isPresented: $isDatePickerPresented) { datePicker }
        .onChange(of: subscribedGroups) { _ in fetchEvents() }
        .onChange(of: allHiddenClasses) { _ in fetchEvents() }
        .onChange(of: scenePhase) { onSceneChange($0) }
        .task { fetchEvents() }
    }

    private var dragGesture: _EndedGesture<DragGesture> {
        DragGesture()
            .onEnded { gesture in
                if gesture.translation.width >= 30 {
                    if let date = viewModel.startDate, viewModel.selectedDate > date {
                        viewModel.shouldScrollToDay = true
                        viewModel.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: viewModel.selectedDate)!
                    }
                } else if gesture.translation.width <= -30 {
                    if let date = viewModel.endDate, viewModel.selectedDate < date {
                        viewModel.shouldScrollToDay = true
                        viewModel.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: viewModel.selectedDate)!
                    }
                }
            }
    }

    private func separator() -> some View {
        Rectangle()
            .fill(.grayShade1)
            .frame(height: 1)
            .opacity(0.1)
    }

    @ViewBuilder
    private var datePicker: some View {
        if let items = viewModel.dayPickerItems {
            CalendarPicker(items: items, selectedDate: $viewModel.selectedDate)
                .padding(.top, .large)
                .presentationDetents([.height(380)])
                .presentationDragIndicator(.visible)
                .ignoresSafeArea(edges: .bottom)

//        if let startDate = viewModel.startDate, let endDate = viewModel.endDate {
//            DatePicker(L10n.selectedDate, selection: $viewModel.selectedDate, in: startDate...endDate, displayedComponents: .date)
//                .datePickerStyle(.graphical)
//                .padding(.horizontal, .medium)
//                .presentationDetents([.height(380)])
//                .presentationDragIndicator(.visible)
//                .tint(Color.accentPrimary)
        }
    }

    @ViewBuilder
    private var loadingIndicatorOrEmptyState: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if !viewModel.isEmpty && viewModel.selectedDateEvents.isEmpty {
            let isWeekend = NSCalendar.current.isDateInWeekend(viewModel.selectedDate)
            Text(isWeekend ? L10n.noEventsWeekendMessage : L10n.noEventsMessage, style: .body)
                .foregroundStyle(.grayShade1)
        }
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack(spacing: 0) {
                TextButton(L10n.myGroups) { isSchedulesSheetPresented = true }
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextButton(L10n.today, action: selectTodaysDate)
                    .frame(maxWidth: .infinity)
                TextButton(L10n.calendar, action: showDatePicker)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, .micro)
        }
    }

    private func selectTodaysDate() {
        viewModel.shouldScrollToDay = true
        viewModel.selectedDate = .now
    }

    private func showDatePicker() {
        guard !viewModel.isLoading && !viewModel.isEmpty else { return }
        isDatePickerPresented = true
    }

    private func onSceneChange(_ scene: ScenePhase) {
        guard scene == .active, !viewModel.shouldUseCachedData else { return }
        fetchEvents()
    }

    private func fetchEvents() {
        Task { try await viewModel.fetchEvents(for: subscribedGroups, hiddenClasses: allHiddenClasses) }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(isFacultiesListPresented: .constant(false))
    }
}
