//
//  FetchAllCitiesUseCaseTests.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 05/06/2022.
//

import XCTest
import Combine
@testable import BackbaseCitySearch

class FetchAllCitiesUseCaseTests: XCTestCase {
    private var sut: FetchAllCitiesUseCase!
    private var mockCitiesFetcher: MockCitiesFetcher!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
        mockCitiesFetcher = MockCitiesFetcher()
        sut = FetchAllCitiesUseCase(citiesFetcher: mockCitiesFetcher)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchAllCitiesUseCase_whenExecutedCalled_loadCitiesIsCalled() {
        let exp = expectation(description: "FetchAllCitiesUseCase test case failed")
        sut.execute()
            .sink { _ in
                
            } receiveValue: { [weak self] cities in
                XCTAssertTrue(self?.mockCitiesFetcher.isLoadCitiesCalled ?? false)
                exp.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [exp], timeout: TestConstants.expectationWaitTime)
    }
    
    func testFetchAllCitiesUseCase_whenExecutedCalled_citiesReturnedCorrectly() {
        let exp = expectation(description: "FetchAllCitiesUseCase test case failed")
        sut.execute()
            .sink { _ in
                
            } receiveValue: { cities in
                XCTAssertEqual(cities, MockData.mockCities)
                exp.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [exp], timeout: TestConstants.expectationWaitTime)
    }
    
}
