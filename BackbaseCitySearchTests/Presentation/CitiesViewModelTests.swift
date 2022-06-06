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
        // Then
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
    
    func testCitiesViewModel_whenAllCitiesAreSelected_shouldHideLoadingMoreCitiesTextIsTrue() {
        // Given
        let exp = expectation(description: "testCitiesViewModel")
        mockFetchCitiesUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { _ in
            } receiveValue: { _ in
                exp.fulfill()
            }.store(in: &cancellables)

        wait(for: [exp], timeout: TestConstants.defaultWaitTime)
        
        // Then
        XCTAssertTrue(sut.shouldHideLoadingMoreCitiesText)
    }
    
    func testCitiesViewModel_whenNotAllCitiesAreSelected_shouldHideLoadingMoreCitiesTextIsFalse() {
        // Given
        let exp = expectation(description: "testCitiesViewModel")
        mockFetchCitiesUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { _ in
            } receiveValue: { _ in
                exp.fulfill()
            }.store(in: &cancellables)

        wait(for: [exp], timeout: TestConstants.defaultWaitTime)
        
        // When
        sut.selectedCities = []
        // Then
        XCTAssertFalse(sut.shouldHideLoadingMoreCitiesText)
    }
    
    
    func testCitiesViewModel_whenSearchTextChange_filterUseCaseIsExecuted() {
        let exp = expectation(description: "TestCitiesViewModel Test Case Failed")
        
        
        // When
        sut.$searchText.dropFirst().removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { _ in
                exp.fulfill()
            }.store(in: &cancellables)
        sut.searchText = "name"
        wait(for: [exp], timeout: TestConstants.defaultWaitTime)
        
        // Then
        XCTAssertTrue(mockfilterCitiesUseCase.isFilterCitiesUseCaseExecuted)
    }
    
    
    func testCitiesViewModel_whenSearchTextChange_selectedCitiesIsUpdated() {
        let exp = expectation(description: "TestCitiesViewModel Test Case Failed")
        
        // When
        sut.$searchText.dropFirst().removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { _ in
                exp.fulfill()
            }.store(in: &cancellables)
        sut.searchText = "name"
        wait(for: [exp], timeout: TestConstants.defaultWaitTime)
        
        // Then
        XCTAssertEqual(sut.selectedCities, MockData.mockSelectedCities)
    }
}
