//
//  ViewModel+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import Foundation

extension ViewModel {
    func pushFacultyGroupDetailsView(_ facultyGroup: FacultyGroup) {
        let viewModel = FacultyGroupDetailsViewModel(navigationController: navigationController, facultyGroup: facultyGroup)
        let viewController = FacultyGroupDetailsViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }
}
