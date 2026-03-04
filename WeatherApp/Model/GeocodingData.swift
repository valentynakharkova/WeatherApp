//
//  GeocodingData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

//MARK: Geocoding Data
struct GeocodingData: Codable, Identifiable, Equatable {
    let name: String
    let localNames: [String: String]?
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    //MARK: For SwiftUI List - makes each item unique
    var id: String {
        "\(name)-\(country)-\(String(format: "%.4f", lat))-\(String(format: "%.4f", lon))"
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        localNames = try? container.decode([String: String].self, forKey: .localNames)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
        country = try container.decode(String.self, forKey: .country)
        state = try? container.decode(String.self, forKey: .state)
    }
}

