//
//  CitiesViewModel.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 03/06/2022.
//

import Foundation
import Combine

class BaseViewModel {
    @Published var state: ViewModelState = .success
    var cancellables = Set<AnyCancellable>()
}
protocol StatefulViewModel {
    var state: ViewModelState { get set }
}

enum ViewModelState {
    case failure
    case success
    case loading
}

protocol CitiesViewModelContract: ObservableObject {
    var cities: [City] { get }
    var citiesPublisher: Published<[City]>.Publisher { get }
}

class CitiesViewModel: BaseViewModel, CitiesViewModelContract {
    // MARK: - Properties
    @Published var cities: [City] = []
    var citiesPublisher: Published<[City]>.Publisher {$cities}
    
    private let fetchCitiesUseCase: FetchCitiesUseCaseContract
    
    // MARK: - Init
    init(fetchCitiesUseCase: FetchCitiesUseCaseContract = FetchCitiesUseCase(citiesFetcher: LocalCitiesFetcher())) {
        self.fetchCitiesUseCase = fetchCitiesUseCase
        super.init()
        fetchCitiesUseCase.fetchAllCities().sink {
            print($0)
        } receiveValue: { [weak self] in
            self?.cities = $0
        }.store(in: &cancellables)
    }
}
