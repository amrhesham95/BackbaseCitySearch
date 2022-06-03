//
//  CitiesFetcher.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 02/06/2022.
//

import Foundation
import Combine

class LocalCitiesFetcher: CitiesFetcher {
    func loadCities() -> AnyPublisher<[City], Error> {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: Constants.citiesFileName, ofType: "json") else {
            fatalError("please add \(Constants.citiesFileName).json")
        }
        let fileURL = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let response = try JSONDecoder().decode([City].self, from: data)
            return Future<[City], Error> { promise in
                promise(.success(response))
            }.eraseToAnyPublisher()
        } catch {
            return Future<[City], Error> { promise in
                promise(.failure(BackbaseError.fileReadingError))
            }
            .eraseToAnyPublisher()
        }

    }
}
