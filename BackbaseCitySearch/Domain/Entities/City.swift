//
//  City.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 02/06/2022.
//

import Foundation
// MARK: - City
struct City: Decodable, Identifiable {
    let country, name: String?
    let id: Int?
    let coordination: Coordination?

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coordination = "coord"
    }
}
