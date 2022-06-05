//
//  LocalCitiesFetcher.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 05/06/2022.
//

import XCTest
import Combine
@testable import BackbaseCitySearch

class LocalCityFetcherTests: XCTestCase {
    private var sut: LocalCitiesFetcher!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
        sut = LocalCitiesFetcher()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testCityFetcher_whenFetchingCities_citiesAreFetchedCorrectly() {
        let exp = expectation(description: "Cities loading test case failed")
        sut.loadCities()
            .sink { _ in
                
            } receiveValue: { cities in
                XCTAssertEqual(cities.count, TestConstants.citiesCount)
                exp.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [exp], timeout: TestConstants.expectationWaitTime)
    }

}