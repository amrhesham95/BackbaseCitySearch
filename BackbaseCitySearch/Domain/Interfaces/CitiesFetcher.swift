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
        return Just(try? Data(contentsOf: fileURL))
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .tryMap({
                guard let data = $0 else { throw BackbaseError.fileReadingError }
                return data
            })
            .decode(type: [City].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
