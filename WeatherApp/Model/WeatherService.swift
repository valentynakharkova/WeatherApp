//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

/// Service responsible for all network requests to the OpenWeatherMap API.
/// Handles fetching current weather, 5-day forecasts, and city search.

class WeatherService {
    
    // MARK: - Private Properties
    private let apiKey = "e2a516767ae4897d82bcbfedb7f417ba"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    // MARK: - Weather
    /// Fetches current weather data for a city by name.
    /// - Parameter city: The name of the city (e.g. "Kyiv")
    /// - Returns: A `WeatherData` object with current weather conditions
    /// - Throws: A network or JSON decoding error
    func fetchWeather(for city: String) async throws -> WeatherData {
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        
        return weatherData
    }
    
    /// Fetches a 5-day weather forecast with 3-hour intervals.
    /// - Parameters:
    /// - lat: The latitude of the city
    /// - lon: The longitude of the city
    /// - Returns: A `ForecastData` object containing the 5-day forecast
    /// - Throws: A network or JSON decoding error
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherData {
        let urlString = "\(baseURL)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("🌤️ Weather API Response:")
            print(jsonString)
        }
        
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        
        return weatherData
    }
    
    //MARK: - Search
    /// Searches for cities matching the given query using the Geocoding API.
    /// Returns up to 5 results with coordinates for each city.
    /// - Parameter query: The search string (minimum 2 characters)
    /// - Returns: An array of `GeocodingData` objects matching the query
    /// - Throws: A network or JSON decoding error
    func searchCities(query: String) async throws -> [GeocodingData] {
        guard query.count >= 2 else {
            return []
        }
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=\(apiKey)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("🔍 Geocoding API Response:")
            print(jsonString)
        }
        
        let cities = try JSONDecoder().decode([GeocodingData].self, from: data)
        
        return cities
    }
    
    //MARK: - Forecast
    /// Fetches a 5-day weather forecast with 3-hour intervals.
    /// - Parameters:
    /// - lat: The latitude of the city
    /// - lon: The longitude of the city
    /// - Returns: A `ForecastData` object containing the 5-day forecast
    /// - Throws: A network or JSON decoding error

    func fetchForecast(lat: Double, lon: Double) async throws -> ForecastData {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // DEBUG: Print the raw response
        if let jsonString = String(data: data, encoding: .utf8) {
            print("📅 Forecast API Response:")
            print(jsonString)
        }
        
        let forecastData = try JSONDecoder().decode(ForecastData.self, from: data)
        
        return forecastData
    }
}

