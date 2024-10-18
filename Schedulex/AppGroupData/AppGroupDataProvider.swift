//
//  AppGroupDataProvider.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 15/10/2024.
//

import Foundation

protocol AppGroupDataProvider {
    func getFacultyGroupEventsByDate() -> FacultyGroupEventsByDay
}
