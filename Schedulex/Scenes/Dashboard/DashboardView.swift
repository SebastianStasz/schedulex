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

final class DashboardViewController: SwiftUIViewController<DashboardViewModel, DashboardView> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

struct DashboardView: RootView {
    @AppStorage("classNotificationsTime") private var classNotificationsTime = ClassNotificationTime.oneHourBefore
    @AppStorage("classNotificationsEnabled") private var classNotificationsEnabled = false
    @AppStorage("showDashboardSwipeTip") private var showDashboardSwipeTip = true
    @StateObject private var viewModel = DashboardViewModelOld()

    @State private var appVersion: String?
    @State private var areSettingsPresented = false
    @State private var isDatePickerPresented = false
    @State private var swipeCount = 0

    @ObservedObject var store: DashboardStore

    var rootBody: some View {
        NavigationStack {
            VStack(spacing: 0) {
                LazyVStack {
                    DayPickerView(items: store.dayPickerItems ?? [], isDatePickerPresented: $isDatePickerPresented, shouldScrollToDay: $store.shouldScrollToDay, selection: $store.selectedDate)
                }
                .padding(.top, .xlarge)
                .padding(.bottom, .medium)
                .background(.backgroundSecondary)

                separator()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: .medium) {
                        if !(store.dayPickerItems == nil) {
                            InfoCardsSection()
//                                .environmentObject(notificationsManager)
                        }
                        EventsList(events: (store.dayPickerItems == nil) ? [] : store.selectedDateEvents)
                            .padding(.vertical, .medium)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.medium)
                    .background(.backgroundPrimary)
                }
                .gesture(dragGesture)
                .overlay { loadingIndicatorOrEmptyState }
            }
            .toolbar { toolbarContent }
            .doubleNavigationTitle(title: title, subtitle: subtitle, showBadge: false, openSettings: { store.navigateTo.send(.settings) })
        }
        .sheet(isPresented: $isDatePickerPresented) { datePicker }
//        .onChange(of: subscribedGroups) { _ in fetchEvents() }
//        .onChange(of: allHiddenClasses) { _ in fetchEvents() }
//        .onChange(of: classNotificationsEnabled) { _ in setClassesNotifications() }
//        .onChange(of: classNotificationsTime) { _ in setClassesNotifications() }
//        .onChange(of: notificationsManager.isNotificationsAccessGranted) { _ in setClassesNotifications() }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification).dropFirst()) { _ in onSceneChange(.active)}
        .task {
//            fetchEvents()
//            appConfigurationService.subscribe(service: FirestoreService())
//            await notificationsManager.updateNotificationsPermission()
        }
    }

    private var title: String {
        store.selectedDate.formatted(style: .dateLong)
    }

    private var subtitle: String {
        store.selectedDate.isSameDay(as: .now) ? L10n.today : L10n.selectedDate
    }

    private var dragGesture: _EndedGesture<DragGesture> {
        DragGesture()
            .onEnded { gesture in
                if gesture.translation.width >= 30 {
                    if let date = store.startDate, store.selectedDate > date {
                        onSwipe()
                        store.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: store.selectedDate)!
                    }
                } else if gesture.translation.width <= -30 {
                    if let date = store.endDate, store.selectedDate < date {
                        onSwipe()
                        store.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: store.selectedDate)!
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
        if let items = store.dayPickerItems {
            CalendarPicker(items: items, selectedDate: $store.selectedDate)
                .padding(.top, .large)
                .presentationDetents([.height(380)])
                .presentationDragIndicator(.visible)
                .ignoresSafeArea(edges: .bottom)
        }
    }

    @ViewBuilder
    private var loadingIndicatorOrEmptyState: some View {
        if store.isLoading {
            ProgressView()
        } else if !store.isLoading, store.selectedDateEvents.isEmpty {
            let isWeekend = NSCalendar.current.isDateInWeekend(store.selectedDate)
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
                TextButton(L10n.myGroups, action: { store.navigateTo.send(.observedFacultyGroups) })
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
        store.shouldScrollToDay = true
        viewModel.selectedDate = .now
    }

    private func showDatePicker() {
        guard !viewModel.isLoading && !viewModel.isEmpty else { return }
        isDatePickerPresented = true
    }

    private func onSwipe() {
        swipeCount += 1
        store.shouldScrollToDay = true
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

    private func setClassesNotifications() {
        guard classNotificationsEnabled else { return }
        let notifications = viewModel.allEvents.compactMap { $0.toLocalNotification(time: classNotificationsTime) }
//        Task { await notificationsManager.setNotifications(notifications) }
    }

    private func fetchEvents() {
        Task {
//            try await viewModel.fetchEvents(for: subscribedGroups, hiddenClasses: allHiddenClasses)
            setClassesNotifications()
        }
    }
}

#Preview {
    DashboardView(store: DashboardStore())
}
