//
//  CitiesView.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 03/06/2022.
//

import SwiftUI

struct CitiesView<ViewModel>: View where ViewModel: CitiesViewModelContract {
    @StateObject var viewModel: ViewModel
    weak var coordinator: AppCoordinator?
    
    var body: some View {
        TextField("Enter a city name", text: $viewModel.searchText)
        List() {
            ForEach(viewModel.selectedCities) { city in
                CityRow(city: city)
            }
            Text("Loading More Universities")
                .onAppear {
                    viewModel.loadMoreCitiesIfNeeded()
                }.isHidden(viewModel.shouldHideLoadingMoreCitiesText)
        }
    }
}
