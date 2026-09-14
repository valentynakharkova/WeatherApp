//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation
import Combine

/// ViewModel responsible for managing weather data and city search.
/// Follows the MVVM architecture pattern and runs on the main actor
/// to ensure all UI updates happen on the main thread.

@MainActor
class WeatherViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Indicates whether a network request is in progress
    @Published var isLoading: Bool = false
    /// Contains an error message if a network request fails
    @Published var errorMessage: String?
    /// List of cities returned from the geocoding search
    @Published var searchResults: [GeocodingData] = []
    /// Indicates whether a city search is in progress
    @Published var isSearching: Bool = false
    /// Dictionary mapping city ID to its current weather data
    @Published var savedCitiesWeather: [String : WeatherData] = [:]
    /// Dictionary mapping city ID to its forecast data
    @Published var savedCitiesForecast: [String : ForecastData] = [:]
    
    // MARK: - Private Properties
    /// Model 
    private let weatherService = WeatherService()
    
    // MARK: - Search
    /// Searches for cities matching the given query.
    /// Results are stored in `searchResults` and displayed in the search list.
    /// - Parameter query: The search string entered by the user
    func searchCities(query: String) {
        Task {
            isSearching = true
            
            do {
                let cities = try await weatherService.searchCities(query: query)
                searchResults = cities
            } catch {
                searchResults = []
            }
            isSearching = false
        }
    }
    
    /// Clears the current search results.
    /// Called when the search field is cleared or dismissed.
    func clearSearch() {
        searchResults = []
    }
    
    // MARK: - Saved Cities
    /// Loads weather and forecast data for a saved city in parallel.
    /// Results are stored in `savedCitiesWeather` and `savedCitiesForecast`
    /// using the city's unique ID as the key.
    /// - Parameter city: The `GeocodingData` object representing the city to load
    func loadCitiesWeather(city: GeocodingData) async {
        do {
            async let weatherTask = weatherService.fetchWeather(lat: city.lat, lon: city.lon)
            async let forecastTask = weatherService.fetchForecast(lat: city.lat, lon: city.lon)

            let (weather, forecast) = try await (weatherTask, forecastTask)
            
            savedCitiesWeather[city.id] = weather
            savedCitiesForecast[city.id] = forecast
            
            print("Saved weather for: \(city.name), id: \(city.id)")
            print("All keys: \(savedCitiesWeather.keys)")
            
        } catch {
            print("Error fetching weather for \(city.name): \(error)")
        }
    }
}
