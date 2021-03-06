//
//  CityRow.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 05/06/2022.
//

import SwiftUI

struct CityRow: View {
    let city: City
    
    init(city: City) {
        self.city = city
    }
    var body: some View {
        LazyVStack(alignment: .leading) {
            LazyHStack {
                Text(city.name ?? "")
                Text(city.country ?? "")
            }.font(.title2)
            
            LazyVStack(alignment: .leading) {
                Text("lat: \(city.coordination?.lat ?? 0)")
                Text("long: \(city.coordination?.lon ?? 0)")
            }.font(.subheadline)
        }
        
    }
}

