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
    var citiesPublisher: Published<[City]>.Publisher { get }
    var selectedCitiesPublished: Published<[City]> { get }
    
    var searchText: String { get set }
    var searchTextPublished: Published<String> { get }
    var searchTextPublisher: Published<String>.Publisher { get }
    
    func loadCities()
    func loadMoreCitiesIfNeeded()
    
}

class CitiesViewModel: BaseViewModel, CitiesViewModelContract {
    
    // MARK: - Properties
    @Published var selectedCities: [City] = []
    var citiesPublisher: Published<[City]>.Publisher {$selectedCities}
    var selectedCitiesPublished: Published<[City]> {_selectedCities}
    
    @Published var searchText = ""
    var searchTextPublished: Published<String> {_searchText}
    var searchTextPublisher: Published<String>.Publisher { $searchText}
    
    private let fetchCitiesUseCase: FetchCitiesUseCaseContract
    private let filterCitiesUseCase: FilterCitiesUseCaseContract
    private var allCities = [City]()
    @Published private var filteredCities = [City]()
    private var pageNumber = 0
    private var pageSize = 20
    
    // MARK: - Init
    init(fetchCitiesUseCase: FetchCitiesUseCaseContract = FetchAllCitiesUseCase(citiesFetcher: LocalCitiesFetcher()),
         filterCitiesUseCase: FilterCitiesUseCaseContract = FilterCitiesUseCase()
    ) {
        self.fetchCitiesUseCase = fetchCitiesUseCase
        self.filterCitiesUseCase = filterCitiesUseCase
        super.init()
        startObservingSearchTextChange()
        startObservingFilteredCities()
        loadCities()
    }
    
    func loadCities() {
        state = .loading
        fetchCitiesUseCase.execute()
            .receive(on: RunLoop.main)
            .sink {
                print($0)
            } receiveValue: { [weak self] in
                self?.allCities = $0
                self?.filteredCities = $0
            }.store(in: &cancellables)
    }
    
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

private extension CitiesViewModel {
    
    func filterCities(_ prefix: String) {
        filterCitiesUseCase.execute(allCities: allCities, prefix: prefix) { [weak self] cities in
            DispatchQueue.main.async {
                self?.filteredCities = cities
            }
        }
    }
    
    func startObservingSearchTextChange() {
        $searchText.drop(while: {$0.isEmpty}).receive(on: RunLoop.main).sink { [weak self] in
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

