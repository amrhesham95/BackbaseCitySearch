//
//  CitiesView.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 03/06/2022.
//

import SwiftUI

struct CitiesView<ViewModel>: View where ViewModel: CitiesViewModelContract {
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.cities) { city in
                HStack {
                    Text(city.name ?? "")
                    Text(city.country ?? "")
                }
            }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(viewModel: CitiesViewModel())
    }
}
