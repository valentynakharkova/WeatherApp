//
//  GeocodingData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

//MARK: Geocoding Data
/// Represents a city returned from the OpenWeatherMap Geocoding API.
/// Used for city search results and storing saved cities.
struct GeocodingData: Codable, Identifiable, Equatable {
    let name: String
    let localNames: [String: String]?
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    // MARK: - Computed Properties
    /// A unique identifier combining name, country and coordinates.
    /// Ensures cities with the same name in different countries are treated as distinct.
    var id: String {
        "\(name)-\(country)-\(String(format: "%.4f", lat))-\(String(format: "%.4f", lon))"
    }
    
    /// A human-readable display name including state and country.
    /// Example: "Kyiv, UA" or "Zaporizhzhia, Zaporizhzhia Oblast, UA"
    var displayName: String {
        if let state = state {
            return "\(name), \(state), \(country)"
        } else {
            return "\(name), \(country)"
        }
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
    
    // MARK: - Init
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

