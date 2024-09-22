//
//  DashboardViewController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/09/2024.
//

import SchedulexViewModel
import Resources

final class DashboardViewController: SwiftUIViewController<DashboardViewModel, DashboardView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.dashboardTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
