//
//  CitiesFetcher.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 02/06/2022.
//

import Foundation
import Combine

protocol CitiesFetcher {
    func loadCities() -> AnyPublisher<[City], Error>
}
