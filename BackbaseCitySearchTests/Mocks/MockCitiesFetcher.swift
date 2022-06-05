//
//  MockCitiesFetcher.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 05/06/2022.
//

import Foundation
import Combine
@testable import BackbaseCitySearch

class MockCitiesFetcher: CitiesFetcher {
    var isLoadCitiesCalled = false
    var simulateErrorWhileLoading = false
    func loadCities() -> AnyPublisher<[City], Error> {
        isLoadCitiesCalled = true
        return Just(MockData.mockCities)
            .tryMap({ cities in
                if simulateErrorWhileLoading {
                    throw TestsError.loadingCitiesError
                }
                return cities
            })
            .eraseToAnyPublisher()
    }
}
