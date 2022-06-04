//
//  AppCoordinator.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 04/06/2022.
//

import Foundation
import UIKit
import SwiftUI

protocol AppCoordinator: AnyObject {
    var navigationController: UINavigationController { get set}
    func start()
    func showDetailsFor(_ city: City)
}

class DefaultAppCoordinator: AppCoordinator {
    var navigationController: UINavigationController
    var flag = true
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let citiesFetcher = LocalCitiesFetcher()
        let fetchUseCase = FetchAllCitiesUseCase(citiesFetcher: citiesFetcher)
        let filterCitiesUseCase = AdvancedFilterUseCase()
        let vm = CitiesViewModel(fetchCitiesUseCase: fetchUseCase, filterCitiesUseCase: filterCitiesUseCase)
        navigationController.pushViewController(UIHostingController(rootView:  CitiesView(viewModel: vm, coordinator: self)), animated: true)
    }

    
    func showDetailsFor(_ city: City) {
        let view = CityDetailsView(city: city)
        navigationController.pushViewController(UIHostingController(rootView: view), animated: true)
    }
}
