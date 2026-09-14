//
//  SavedCityManager.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 17.02.2026.
//

import Combine
import SwiftUI

/// Manages the list of saved cities and persists them to UserDefaults.
/// Implemented as a singleton to ensure a single source of truth across all views.

class SavedCityManager: ObservableObject {
    
    // MARK: - Singleton
    /// Shared instance used across the app
    static let shared = SavedCityManager()
    
    // MARK: - Published Properties
    /// The current list of saved cities, limited to 5 entries
    @Published private(set) var savedCities: [GeocodingData] = []
    
    // MARK: - Private Properties
    
    /// Maximum number of cities a user can save
    private let maxCities = 5
    /// Key used to store and retrieve cities from UserDefaults
    private let saveKey = "saveKey"
    
    // MARK: - Init
    private init() {
        load()
    }
    
    // MARK: - Public Interface
    /// A binding to the saved cities array for use in SwiftUI views.
    /// Automatically persists changes when the array is modified.
    var citiesBinding: Binding<[GeocodingData]> {
        Binding(
            get: { self.savedCities },
            set: { self.savedCities = $0; self.persist() }
        )
    }
    
    /// Replaces the entire saved cities list with a new array.
    /// - Parameter newCities: The new array of cities to save
    func updateCities(_ newCities: [GeocodingData]) {
        savedCities = newCities
        persist()
    }
    
    /// Saves a new city to the list if it doesn't already exist and the limit hasn't been reached.
    /// - Parameter city: The `GeocodingData` object representing the city to save
    func saveCity(_ city: GeocodingData) {
        // Don't save dublicats
        if savedCities.contains(where: { $0.name == city.name && $0.country == city.country }) { return }
        
        guard savedCities.count < maxCities else { return }
        
        savedCities.append(city)
        persist()
    }
    
    /// Removes a city from the saved list.
    /// - Parameter city: The `GeocodingData` object representing the city to remove
    func removeCity(_ city: GeocodingData) {
        savedCities.removeAll(where: { $0.name == city.name && $0.country == city.country })
        persist()
    }
    
    /// Moves a city from one position to another in the saved list.
    /// Used to support drag-to-reorder in the cities list.
    /// - Parameters:
    ///   - source: The index set of the city being moved
    ///   - destination: The target index to move the city to
    func moveCity(from sourse: IndexSet, to destination: Int) {
        savedCities.move(fromOffsets: sourse, toOffset: destination)
        persist()
    }
    
    // MARK: - Private Methods
    /// Encodes the saved cities array and writes it to UserDefaults.
    private func persist() {
        if let encoded = try? JSONEncoder().encode(savedCities) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    /// Loads saved cities from UserDefaults on app launch.
    /// Falls back to an empty array if no data is found or decoding fails.
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: saveKey),
              let decoded = try? JSONDecoder().decode([GeocodingData].self, from: data) else { return }
        savedCities = decoded
    }
    
}
