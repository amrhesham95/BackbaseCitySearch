//
//  CitiesViewModel.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 03/06/2022.
//

import Foundation
import Combine

protocol CitiesViewModelContract: ObservableObject {
    var selectedCities: [City] { get }
    var searchText: String { get set }
    var numberOfCities: String { get }
    var shouldHideLoadingMoreCitiesText: Bool { get }
    func loadMoreCitiesIfNeeded()
}

class CitiesViewModel: BaseViewModel, CitiesViewModelContract {
    
    // MARK: - Properties
    @Published var selectedCities: [City] = []
    @Published var searchText = ""
    var numberOfCities: String {
        filteredCities.count.description
    }
    var shouldHideLoadingMoreCitiesText: Bool {
         return !(filteredCities.count > selectedCities.count)
    }
    
    @Published private var filteredCities = [City]()
    private let fetchCitiesUseCase: FetchCitiesUseCaseContract
    private let filterCitiesUseCase: FilterCitiesUseCaseContract
    private var allCities = [City]()
    private var pageNumber = 0
    private var pageSize = 20
    
    // MARK: - Init
    init(fetchCitiesUseCase: FetchCitiesUseCaseContract,
         filterCitiesUseCase: FilterCitiesUseCaseContract
    ) {
        self.fetchCitiesUseCase = fetchCitiesUseCase
        self.filterCitiesUseCase = filterCitiesUseCase
        super.init()
        startObservingSearchTextChange()
        startObservingFilteredCities()
        loadCities()
    }
        
    /* mobile side pagination to avoid SwiftUI performance issue when updating the list with big array */
    func loadMoreCitiesIfNeeded() {
        var pageOfCities = [City]()
        var lowerBound = 0
        var upperBound = 0
        
        if filteredCities.count >= pageSize*(pageNumber+1) {
            lowerBound = pageSize*pageNumber
            upperBound = pageSize*(pageNumber+1)
        } else {
            lowerBound = pageSize*pageNumber
            upperBound = filteredCities.count
        }
        while (lowerBound < upperBound) {
            let city = filteredCities[lowerBound]
            pageOfCities.append(city)
            lowerBound += 1
        }
        pageNumber += 1
        selectedCities.append(contentsOf: pageOfCities)
    }
}

// MARK: - Private Helpers
//
private extension CitiesViewModel {
    
    func loadCities() {
        state = .loading
        fetchCitiesUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { _ in
            } receiveValue: { [weak self] in
                guard let self = self else { return }
                self.allCities = $0.sorted(by: { ($0.name ?? "", $0.country ?? "") <= ($1.name ?? "", $1.country ?? "") })
                self.filteredCities = self.allCities
            }.store(in: &cancellables)
    }
    
    func filterCities(_ prefix: String) {
        filterCitiesUseCase.execute(allCities: allCities, prefix: prefix) { [weak self] cities in
            DispatchQueue.main.async {
                self?.filteredCities = cities
            }
        }
    }
    
    func startObservingSearchTextChange() {
        $searchText.dropFirst()
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.filterCities($0)
            }.store(in: &cancellables)
    }
    
    func startObservingFilteredCities() {
        $filteredCities.receive(on: RunLoop.main).sink { [weak self] _ in
            guard let self = self else { return }
            self.selectedCities = []
            self.pageNumber = 0
            self.loadMoreCitiesIfNeeded()
        }.store(in: &cancellables)
    }
}

