//
//  SchoolStore.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import Domain
import Foundation

final class SchoolStore: RootStore {
    @Published var school: School?
    @Published var searchText = ""
}
