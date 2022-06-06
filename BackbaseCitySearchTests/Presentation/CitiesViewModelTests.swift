//
//  CitiesViewModelTests.swift
//  BackbaseCitySearchTests
//
//  Created by Amr Hesham on 05/06/2022.
//

import XCTest
import Combine
@testable import BackbaseCitySearch


class CitiesViewModelTests: XCTestCase {
    private var sut: CitiesViewModel!
    private var mockFetchCitiesUseCase: MockFetchCitiesUseCase!
    private var mockfilterCitiesUseCase: MockFilterCitiesUseCase!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
        mockFetchCitiesUseCase = MockFetchCitiesUseCase()
        mockfilterCitiesUseCase = MockFilterCitiesUseCase()
        sut = CitiesViewModel(fetchCitiesUseCase: mockFetchCitiesUseCase,
                              filterCitiesUseCase: mockfilterCitiesUseCase)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testCitiesViewModel_whenInit_fetchAllCitiesIsExecuted() {
        XCTAssertTrue(mockFetchCitiesUseCase.isFetchCitiesUseCaseExecuted)
    }
    
    func testCitiesViewModel_whenStateIsLoading_isLoadingFinishedIsFalse() {
        // When
        sut.state = .loading
        
        // Then
        XCTAssertFalse(sut.isLoadingFinished)
    }
    
    func testCitiesViewModel_whenStateIsSuccess_isLoadingFinishedIsTrue() {
        // When
        sut.state = .success
        
        // Then
        XCTAssertTrue(sut.isLoadingFinished)
    }

    
    func testCitiesViewModel_whenSearchTextChange_filterUseCaseIsExecuted() {
        let exp = expectation(description: "TestCitiesViewModel Test Case Failed")
        
        
        sut.$searchText.dropFirst().removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { _ in
                exp.fulfill()
            }.store(in: &cancellables)
        sut.searchText = "name"
        wait(for: [exp], timeout: TestConstants.defaultWaitTime)
        XCTAssertTrue(mockfilterCitiesUseCase.isFilterCitiesUseCaseExecuted)
    }
    
    
    func testCitiesViewModel_whenSearchTextChange_selectedCitiesIsUpdated() {
        let exp = expectation(description: "TestCitiesViewModel Test Case Failed")
        
        
        sut.$searchText.dropFirst().removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { _ in
                exp.fulfill()
            }.store(in: &cancellables)
        sut.searchText = "name"
        wait(for: [exp], timeout: TestConstants.defaultWaitTime)
        XCTAssertEqual(sut.selectedCities, MockData.mockSelectedCities)
    }
}
