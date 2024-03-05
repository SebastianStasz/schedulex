//
//  CombineHelper.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Combine

protocol CombineHelper: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
}
