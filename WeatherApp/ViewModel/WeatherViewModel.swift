//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var searchResults: [GeocodingData] = []
    @Published var isSearching: Bool = false
    
    @Published var forecastData: ForecastData?
    
    @Published var savedCitiesWeather: [String : WeatherData] = [:]
    @Published var savedCitiesForecast: [String : ForecastData] = [:]
    
    private let weatherService = WeatherService()
    
    func getWeather(for city: String) {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                let data = try await weatherService.fetchWeather(for: city)
                weatherData = data
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func getWeather(lat: Double, lon: Double) {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                //MARK: Fetch both weather and forecast in parralel
                async let weatherTask = try await weatherService.fetchWeather(lat: lat, lon: lon)
                async let forecastTask = try await weatherService.fetchForecast(lat: lat, lon: lon)
                
                let (weather, forecast) = try await (weatherTask, forecastTask)
                
                weatherData = weather
                forecastData = forecast
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
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
    
    func clearSearch() {
        searchResults = []
    }
    
    func loadCitiesWeather(city: GeocodingData) async {
        do {
            async let weatherTask = weatherService.fetchWeather(lat: city.lat, lon: city.lon)
            async let forecastTask = weatherService.fetchForecast(lat: city.lat, lon: city.lon)

            let (weather, forecast) = try await (weatherTask, forecastTask)
            
            savedCitiesWeather[city.id] = weather
            savedCitiesForecast[city.id] = forecast
            
            print("✅ Saved weather for: \(city.name), id: \(city.id)")
            print("📦 All keys: \(savedCitiesWeather.keys)")
            
        } catch {
            print("❌ Error fetching weather for \(city.name): \(error)")
        }
    }
}
