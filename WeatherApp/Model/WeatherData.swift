//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

//MARK: Weather Data
/// Root model representing the current weather response from OpenWeatherMap API.
struct WeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int?
    let rain: Rain?
    let snow: Snow?
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    /// City's timezone offset in seconds from UTC. Used to display correct local times.
    let timezone, id: Int
    let name: String
    let cod: Int
}
//MARK: Extension Weather Data
/// Converts a UTC Unix timestamp to a formatted local time string for the city.
/// Uses the city's `timezone` offset to ensure the correct local time is displayed
/// regardless of the user's device timezone.
/// - Parameter timestamp: A Unix timestamp in seconds (e.g. sunrise or sunset)
/// - Returns: A formatted time string in "HH:mm" format
extension WeatherData {
    func formatTime(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp + timezone))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: date)
    }
}

//MARK: Coord
/// Geographic coordinates of a city.
struct Coord: Codable {
    let lon, lat: Double
}

//MARK: Weather
/// Weather condition with an ID, group name, description and icon code.
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

//MARK: Main
/// Core temperature and atmospheric data.
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

//MARK: Wind
/// Wind speed, gust and direction data.
struct Wind: Codable {
    let speed: Double
    let gust: Double?
    let deg: Int
}

//MARK: Clouds
/// Cloud coverage data.
struct Clouds: Codable {
    let all: Int
}

//MARK: Sys
/// System data including country code and sunrise/sunset timestamps.
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

//MARK: Rain
/// Rainfall volume data.
struct Rain: Codable {
    let oneHour: Double?
    let threeHours: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

//MARK: Snow
/// Snowfall volume data.
struct Snow: Codable {
    let oneHour: Double?
    let threeHours: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

