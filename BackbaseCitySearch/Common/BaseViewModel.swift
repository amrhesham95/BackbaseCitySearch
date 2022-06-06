//
//  BaseViewModel.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 03/06/2022.
//

import Foundation
import Combine
class BaseViewModel {
    @Published var state: ViewModelState = .success
    var cancellables = Set<AnyCancellable>()
}
