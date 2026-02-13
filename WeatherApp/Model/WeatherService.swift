//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

class WeatherService {
    private let apiKey = "e2a516767ae4897d82bcbfedb7f417ba"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String) async throws -> WeatherData {
        
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        
        return weatherData
    }
    
    // MARK: Fetch current wether by coordinates (lat/lon)
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherData {
        let urlString = "\(baseURL)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        
        return weatherData
    }
    
    //MARK: Search for cities using Geocoding API
    func searchCities(query: String) async throws -> [GeocodingData] {
        guard query.count >= 2 else {
            return []
        }
        let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=\(apiKey)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let cities = try JSONDecoder().decode([GeocodingData].self, from: data)
        
        return cities
    }
    
    //MARK: Fetch 5 day forecast by coordinates
    func fetchForecast(lat: Double, lon: Double) async throws -> ForecastData {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let forecastData = try JSONDecoder().decode(ForecastData.self, from: data)
        
        return forecastData
    }
    
    
    
}

