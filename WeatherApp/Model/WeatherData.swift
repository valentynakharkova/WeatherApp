//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

//MARK: Weather Data
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
    let timezone, id: Int
    let name: String
    let cod: Int
}
//MARK: Extension Weather Data
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
struct Coord: Codable {
    let lon, lat: Double
}

//MARK: Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

//MARK: Main
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
struct Wind: Codable {
    let speed: Double
    let gust: Double?
    let deg: Int
}

//MARK: Clouds
struct Clouds: Codable {
    let all: Int
}

//MARK: Sys
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

//MARK: Rain
struct Rain: Codable {
    let oneHour: Double?
    let threeHours: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

//MARK: Snow
struct Snow: Codable {
    let oneHour: Double?
    let threeHours: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

