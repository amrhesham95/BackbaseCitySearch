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
                VStack(alignment: .leading) {
                    HStack {
                        Text(city.name ?? "")
                        Text(city.country ?? "")
                    }.font(.title2)
                    
                    VStack(alignment: .leading) {
                        Text("lat: \(city.coordination?.lat ?? 0)")
                        Text("long: \(city.coordination?.lon ?? 0)")
                    }.font(.subheadline)
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
