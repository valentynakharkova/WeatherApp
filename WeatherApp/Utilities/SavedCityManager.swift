//
//  SavedCityManager.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 17.02.2026.
//

import Foundation
import Combine

class SavedCityManager: ObservableObject {
    
    static let shared = SavedCityManager()
    
    @Published var savedCities: [GeocodingData] = []
    
    private let maxCities = 5
    private let saveKey = "saveKey"
    
    private init() {
        load()
    }
    
    func saveCity(_ city: GeocodingData) {
        // Don't save dublicats
        if savedCities.contains(where: { $0.name == city.name && $0.country == city.country }) { return }
                
        if savedCities.count > maxCities {
            savedCities.removeFirst()
        }
        
        savedCities.append(city)
        persist()
    }
    
    func removeCity(_ city: GeocodingData) {
        savedCities.removeAll(where: { $0.name == city.name && $0.country == city.country })
        persist()
    }
    
    private func persist() {
        if let encoder = try? JSONEncoder().encode(savedCities) {
            UserDefaults.standard.set(encoder, forKey: saveKey)
        }
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: saveKey),
              let decoded = try? JSONDecoder().decode([GeocodingData].self, from: data) else { return }
        
        savedCities = decoded

    }
    
}
