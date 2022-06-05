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
        TextField("Search", text: $viewModel.searchText)        
        List(viewModel.selectedCities, id: \.self.id) { city in
            CityRow(city: city)
        }.id(UUID())
        
        Text("Loading More Universities")
            .onAppear {
                viewModel.loadMoreCitiesIfNeeded()
            }
        
    }
}
