//
//  StartFlowViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/10/2023.
//

import Domain
import Foundation
import SchedulexFirebase

@MainActor
final class StartFlowViewModel: ObservableObject {
    @Published private var school: School?
    @Published var selectedGroups: [FacultyGroup] = []
    @Published var selectedLanguages: [FacultyGroup] = []

    private let service: FirestoreService

    init(service: FirestoreService = FirestoreService()) {
        self.service = service
    }

    var isLoading: Bool {
        school == nil
    }

    var canConfirmSelection: Bool {
        !allSelectedGroups.isEmpty
    }

    var allSelectedGroups: [FacultyGroup] {
        selectedGroups + selectedLanguages
    }

    var facultyGroups: [FacultyGroup] {
        school?.allGroupsWithoutLanguages ?? []
    }

    var languageGroups: [FacultyGroup] {
        school?.languageGroups ?? []
    }

    func fetchData() async throws {
        school = try await service.getCracowUniversityOfEconomics()
    }
}
