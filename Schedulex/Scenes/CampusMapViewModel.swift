//
//  CampusMapViewModel.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/10/2024.
//

import SchedulexCore
import SchedulexViewModel
import UIKit

final class CampusMapStore: RootStore {}

struct CampusMapViewModel: ViewModel {
    var navigationController: UINavigationController?

    func makeStore(context: Context) -> CampusMapStore {
        let store = CampusMapStore()
        return store
    }
}
