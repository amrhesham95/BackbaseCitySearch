//
//  CitiesView.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 03/06/2022.
//

import SwiftUI

struct CitiesView<ViewModel>: View where ViewModel: CitiesViewModelContract {
    @StateObject var viewModel: ViewModel
    
//    init(viewModel: ViewModel) {
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        TextField("Search", text: $viewModel.searchText)
        List {
            ForEach(viewModel.selectedCities) { city in
                HStack {
                    Text(city.name ?? "")
                    Text(city.country ?? "")
                }
            }
            Text("Loading More Universities")
                .onAppear {
                    viewModel.loadMoreCitiesIfNeeded()
                }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(viewModel: CitiesViewModel())
    }
}
