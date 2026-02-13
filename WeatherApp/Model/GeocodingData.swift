//
//  GeocodingData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

//MARK: Geocoding Data
struct GeocodingData: Codable, Identifiable {
    let name: String
    let localNames: [String: String]?
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    //MARK: For SwiftUI List - makes each item unique
    var id: String {
        "\(name)-\(country)-\(lat)-\(lon)"
    }
    
    //MARK: Display name with country
    var displayName: String {
        if let state = state {
            return "\(name), \(state), \(country)"
        } else {
            return "\(name), \(country)"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

