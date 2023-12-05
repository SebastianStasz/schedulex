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
    @AppStorage("classNotificationsEnabled") private var classNotificationsEnabled = false
    @AppStorage("showDashboardSwipeTip") private var showDashboardSwipeTip = true
    @AppStorage("hiddenInfoCards") private var hiddenInfoCards: [InfoCard] = []
    @StateObject private var viewModel = DashboardViewModel()
    @StateObject private var notificationsManager = NotificationsManager()
    @EnvironmentObject private var service: FirestoreService
    @Environment(\.scenePhase) private var scenePhase

    @State private var areSettingsPresented = false
    @State private var areMyGroupsPresented = false
    @State private var isDatePickerPresented = false
    @State private var swipeCount = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                LazyVStack {
                    DayPickerView(items: viewModel.dayPickerItems ?? [], isDatePickerPresented: $isDatePickerPresented, shouldScrollToDay: $viewModel.shouldScrollToDay, selection: $viewModel.selectedDate)
                }
                .padding(.top, .xlarge)
                .padding(.bottom, .medium)
                .background(.backgroundSecondary)

                separator()

                ScrollView {
                    VStack(spacing: .medium) {
                        InfoCardsSection()
                            .environmentObject(notificationsManager)

                        ForEach(viewModel.isLoading ? [] : viewModel.selectedDateEvents, id: \.self) {
                            EventCardView(event: $0)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.medium)
                    .background(.backgroundPrimary)
                }
                .gesture(dragGesture)
                .overlay { loadingIndicatorOrEmptyState }
            }
            .toolbar { toolbarContent }
            .doubleNavigationTitle(title: viewModel.title, subtitle: viewModel.subtitle, showSettings: {
                areSettingsPresented = true
            })
            .navigationTitle("‎‎‎‏‏‎")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $areSettingsPresented) { SettingsView().environmentObject(notificationsManager) }
            .navigationDestination(isPresented: $areMyGroupsPresented) { ObservedFacultyGroupsView(service: service) }
        }
        .sheet(isPresented: $isDatePickerPresented) { datePicker }
        .onChange(of: subscribedGroups) { _ in fetchEvents() }
        .onChange(of: allHiddenClasses) { _ in fetchEvents() }
        .onChange(of: scenePhase) { onSceneChange($0) }
        .task {
            await notificationsManager.updateNotificationsPermission()
        }
    }

    private var dragGesture: _EndedGesture<DragGesture> {
        DragGesture()
            .onEnded { gesture in
                if gesture.translation.width >= 30 {
                    if let date = viewModel.startDate, viewModel.selectedDate > date {
                        onSwipe()
                        viewModel.shouldScrollToDay = true
                        viewModel.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: viewModel.selectedDate)!
                    }
                } else if gesture.translation.width <= -30 {
                    if let date = viewModel.endDate, viewModel.selectedDate < date {
                        onSwipe()
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
        }
    }

    @ViewBuilder
    private var loadingIndicatorOrEmptyState: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if !viewModel.isEmpty && viewModel.selectedDateEvents.isEmpty {
            let isWeekend = NSCalendar.current.isDateInWeekend(viewModel.selectedDate)
            HStack(spacing: .micro) {
                Text(isWeekend ? L10n.noEventsWeekendMessage : L10n.noEventsMessage, style: .body)
                    .foregroundStyle(.grayShade1)

                if isWeekend {
                    SwiftUI.Text("🍻")
                        .font(.title)
                }
            }
        }
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack(spacing: 0) {
                TextButton(L10n.myGroups) { areMyGroupsPresented = true }
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

    private func onSwipe() {
        swipeCount += 1
        guard showDashboardSwipeTip, swipeCount > 3 else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                showDashboardSwipeTip = false
            }
        }
    }

    private func onSceneChange(_ scene: ScenePhase) {
        guard scene == .active, !viewModel.shouldUseCachedData else { return }
        fetchEvents()
    }

    private func fetchEvents() {
        Task {
            try await viewModel.fetchEvents(for: subscribedGroups, hiddenClasses: allHiddenClasses)
            guard classNotificationsEnabled else { return }
            let notifications = viewModel.allEvents.compactMap { $0.toLocalNotification() }
            await notificationsManager.setNotifications(notifications)
        }
    }
}

#Preview {
    DashboardView()
}
