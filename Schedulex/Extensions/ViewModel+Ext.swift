//
//  ViewModel+Ext.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/01/2024.
//

import Domain
import Foundation
import SchedulexViewModel

extension ViewModel {
    func pushFacultyGroupDetailsView(_ facultyGroup: FacultyGroup, viewType: FacultyGroupDetailsViewType) {
        let viewModel = FacultyGroupDetailsViewModel(navigationController: navigationController, viewType: viewType, facultyGroup: facultyGroup)
        let viewController = FacultyGroupDetailsViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    func pushEventsListView(input: EventsListInput) {
        let viewModel = EventsListViewModel(input: input)
        let viewController = EventsListViewController(viewModel: viewModel)
        navigationController?.push(viewController)
    }

    func pushCampusMapView(with building: UekBuilding? = nil) {
        if #available(iOS 17.0, *) {
            let viewModel = CampusMapViewModel(navigationController: navigationController, building: building)
            let viewController = CampusMapViewController(viewModel: viewModel)
            navigationController?.push(viewController)
        }
    }
}
