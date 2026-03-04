//
//  SavedCityManager.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 17.02.2026.
//

import Combine
import SwiftUI

class SavedCityManager: ObservableObject {
    
    static let shared = SavedCityManager()
    
    @Published private(set) var savedCities: [GeocodingData] = []
    
    private let maxCities = 5
    private let saveKey = "saveKey"
    
    private init() {
        load()
    }
    
    var citiesBinding: Binding<[GeocodingData]> {
        Binding(
            get: { self.savedCities },
            set: { self.savedCities = $0; self.persist() }
        )
    }
    //MARK: Update Cities
    func updateCities(_ newCities: [GeocodingData]) {
        savedCities = newCities
        persist()
    }
    //MARK: Save City
    func saveCity(_ city: GeocodingData) {
        // Don't save dublicats
        if savedCities.contains(where: { $0.name == city.name && $0.country == city.country }) { return }
        
        guard savedCities.count < maxCities else { return }
        
        savedCities.append(city)
        persist()
    }
    //MARK: Remove City
    func removeCity(_ city: GeocodingData) {
        savedCities.removeAll(where: { $0.name == city.name && $0.country == city.country })
        persist()
    }
    //MARK: Move City
    func moveCity(from sourse: IndexSet, to destination: Int) {
        savedCities.move(fromOffsets: sourse, toOffset: destination)
        persist()
    }
    //MARK: Persist
    private func persist() {
        if let encoded = try? JSONEncoder().encode(savedCities) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    //MARK: Load
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: saveKey),
              let decoded = try? JSONDecoder().decode([GeocodingData].self, from: data) else { return }
        savedCities = decoded
    }
    
}
