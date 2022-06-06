//
//  CityDetails.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 04/06/2022.
//

import SwiftUI
import MapKit

struct CityDetailsView: View {
    private var city: City
    @State private var region: MKCoordinateRegion
    init(city: City) {
        self.city = city
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: city.coordination?.lat ?? 0, longitude: city.coordination?.lon ?? 0),
            span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        )
        
    }
    var body: some View {
        HStack {
            Text(city.name ?? "")
                .padding()
                .font(.title)
            Spacer()
        }
        Map(coordinateRegion: $region)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//struct CityDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        CityDetailsView()
//    }
//}
