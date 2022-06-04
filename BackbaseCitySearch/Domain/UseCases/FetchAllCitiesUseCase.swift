//
//  FetchCitiesUseCase.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 03/06/2022.
//

import Foundation
import Combine

protocol FetchCitiesUseCaseContract {
    func execute() -> AnyPublisher<[City], Error>
}

class FetchAllCitiesUseCase: FetchCitiesUseCaseContract {
    private let citiesFetcher: CitiesFetcher
    
    init(citiesFetcher: CitiesFetcher) {
        self.citiesFetcher = citiesFetcher
    }
    func execute() -> AnyPublisher<[City], Error> {
        return citiesFetcher.loadCities()
    }
}
