//
//  MockData.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 05/06/2022.
//

import Foundation
@testable import BackbaseCitySearch

class MockData {
    static var mockCities: [City] = [
        .init(country: "country1", name: "name a", id: 1, coordination: Coordination(lon: 1, lat: 1)),
        .init(country: "country2", name: "name b", id: 2, coordination: Coordination(lon: 2, lat: 2)),
        .init(country: "country3", name: "name c", id: 3, coordination: Coordination(lon: 3, lat: 3))
    ]
    
    static var mockSelectedCities: [City] = [
        .init(country: "selected1", name: "name1", id: 1, coordination: Coordination(lon: 1, lat: 1)),
        .init(country: "selected2", name: "name2", id: 2, coordination: Coordination(lon: 2, lat: 2)),
        .init(country: "selected3", name: "name3", id: 3, coordination: Coordination(lon: 3, lat: 3))
    ]

}
