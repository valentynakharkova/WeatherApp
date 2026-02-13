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
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
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

//MARK:
struct Main: Codable {
    let temp, feelslike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelslike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

//MARK: Wind
struct Wind: Codable {
    let speed, gust: Double
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
