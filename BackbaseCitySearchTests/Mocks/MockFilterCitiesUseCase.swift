//
//  MockFilterCitiesUseCase.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 06/06/2022.
//

import Foundation
@testable import BackbaseCitySearch

class MockFilterCitiesUseCase: FilterCitiesUseCaseContract {
    var isFilterCitiesUseCaseExecuted = false
    func execute(allCities: [City], prefix: String, completion: @escaping (([City]) -> Void)) {
        isFilterCitiesUseCaseExecuted = true
        completion(MockData.mockSelectedCities)
    }
}
