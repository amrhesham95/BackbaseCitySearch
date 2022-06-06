//
//  AdvancedFilterUseCase.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 04/06/2022.
//

import Foundation

protocol FilterCitiesUseCaseContract {
    func execute(allCities: [City], prefix: String, completion: @escaping (([City]) -> Void))
}
class BinarySearchFilterCitiesUseCase: FilterCitiesUseCaseContract {
    func execute(allCities: [City], prefix: String, completion: @escaping (([City]) -> Void)) {
        if prefix.isEmpty {
            completion(allCities)
            return
        }
        let lowerCasedSearchString = prefix.lowercased()
        var leftIndex = 0
        var rightIndex = allCities.count - 1
        var resultIndex = -1
        
        // Find an index for a city that starts with the search string
        while leftIndex <= rightIndex {
            let middleIndex = Int(floor(Double(leftIndex + rightIndex) / 2.0))
            guard let middleCityName = allCities[middleIndex].name?.lowercased() else { return }
            
            if middleCityName.starts(with: lowerCasedSearchString) {
                resultIndex = middleIndex
                break
            }
            
            if middleCityName < prefix.lowercased() {
                leftIndex = middleIndex + 1
            } else if middleCityName > lowerCasedSearchString {
                rightIndex = middleIndex - 1
            }
        }
        
        // Find all cities starting with the search string
        var result = [City]()
        if resultIndex > -1 {
            for index in stride(from: resultIndex, to: -1, by: -1) {
                guard let cityName = allCities[index].name?.lowercased() else { return }
                if cityName.starts(with: lowerCasedSearchString) == false {
                    break
                }
                result.insert(allCities[index], at: 0)
            }
            
            for index in (resultIndex+1)..<allCities.count {
                guard let cityName = allCities[index].name?.lowercased() else { return }
                if cityName.starts(with: lowerCasedSearchString) == false {
                    break
                }
                result.append(allCities[index])
            }
        }
        
        completion(result)
    }
}
