//
//  ViewModel+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import Foundation

extension ViewModel {
    func pushFacultyGroupDetailsView(_ facultyGroup: FacultyGroup, viewType: FacultyGroupDetailsViewType) {
        let viewModel = FacultyGroupDetailsViewModel(navigationController: navigationController, viewType: viewType, facultyGroup: facultyGroup)
        let viewController = FacultyGroupDetailsViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
