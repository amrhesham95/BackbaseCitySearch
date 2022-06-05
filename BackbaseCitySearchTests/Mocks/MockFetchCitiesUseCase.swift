//
//  MockFetchCitiesUseCase.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 06/06/2022.
//

import Foundation
import Combine
@testable import BackbaseCitySearch

class MockFetchCitiesUseCase: FetchCitiesUseCaseContract {
    var isFetchCitiesUseCaseExecuted = false
    var simulateErrorWhileFetching = false
    
    func execute() -> AnyPublisher<[City], Error> {
        isFetchCitiesUseCaseExecuted = true
        return Just(MockData.mockCities)
            .tryMap({ cities in
                if simulateErrorWhileFetching {
                    throw TestsError.loadingCitiesError
                }
                return cities
            })
            .eraseToAnyPublisher()
    }
}
