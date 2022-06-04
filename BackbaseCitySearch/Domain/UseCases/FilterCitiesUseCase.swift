//
//  FilterCitiesUseCase.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 04/06/2022.
//

import Foundation

protocol FilterCitiesUseCaseContract {
    func execute(allCities: [City], prefix: String, completion: @escaping (([City]) -> Void))
}
class FilterCitiesUseCase: FilterCitiesUseCaseContract {
    func execute(allCities: [City], prefix: String, completion: @escaping (([City]) -> Void)) {
        DispatchQueue.global().async {
            if prefix.isEmpty {
                completion(allCities)
            } else {
                let filteredCities = allCities.filter { city in
                    guard let cityName = city.name else { return false }
                    return cityName.hasPrefix(prefix)
                }
                completion(filteredCities)
            }
            
        }
    }
}
