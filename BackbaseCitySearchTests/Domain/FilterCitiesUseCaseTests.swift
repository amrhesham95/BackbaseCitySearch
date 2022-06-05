//
//  FilterCitiesUseCaseTests.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 05/06/2022.
//

import XCTest
import Combine
@testable import BackbaseCitySearch

class FilterCitiesUseCaseTests: XCTestCase {
    private var sut: FilterCitiesUseCase!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
        sut = FilterCitiesUseCase()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFilterCitiesUseCase_whenExecutedCalledWithEmptyPrefix_allCitiesReturned() {
        let exp = expectation(description: "FilterCitiesUseCase test case failed")
        sut.execute(allCities: MockData.mockCities, prefix: "") { cities in
            XCTAssertEqual(cities, MockData.mockCities)
            exp.fulfill()
        }
        wait(for: [exp], timeout: TestConstants.expectationWaitTime)
    }
    
    func testFilterCitiesUseCase_whenExecutedCalledWithPrefix_onlyMatchingCitiesAreReturned() {
        let exp = expectation(description: "FilterCitiesUseCase test case failed")
        sut.execute(allCities: MockData.mockCities, prefix: "name") { cities in
            XCTAssertEqual(cities.count, 3)
            exp.fulfill()
        }
        wait(for: [exp], timeout: TestConstants.expectationWaitTime)
    }
    
    func testFilterCitiesUseCase_whenExecutedCalledWithPrefix_onlyMatchingCitiesAreReturned2() {
        let exp = expectation(description: "FilterCitiesUseCase test case failed")
        sut.execute(allCities: MockData.mockCities, prefix: "name1") { cities in
            XCTAssertEqual(cities.count, 1)
            exp.fulfill()
        }
        wait(for: [exp], timeout: TestConstants.expectationWaitTime)
    }
    
    func testFilterCitiesUseCase_whenExecutedCalledWithnotFoundPrefix_emptyListReturned() {
        let exp = expectation(description: "FilterCitiesUseCase test case failed")
        sut.execute(allCities: MockData.mockCities, prefix: "zxcv") { cities in
            XCTAssertEqual(cities.count, 0)
            exp.fulfill()
        }
        wait(for: [exp], timeout: TestConstants.expectationWaitTime)
    }
}
