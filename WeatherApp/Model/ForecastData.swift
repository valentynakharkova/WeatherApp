//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

//MARK: Forecast Data
/// Root model representing the 5-day forecast response from OpenWeatherMap API.
/// Contains a list of forecast items in 3-hour intervals and city metadata.
struct ForecastData: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastItem]
    let city: City
}

//MARK: Forecast Item
/// A single forecast entry representing weather conditions at a specific point in time.
struct ForecastItem: Codable, Identifiable {
    let dt: Int
    let main: ForecastMain
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int?
    let pop: Double
    let rain: Rain?
    let snow: Snow?
    let sys: ForecastSys
    let dtTxt: String
    
    var id: Int { dt }
    
    //MARK: Helper to convert Timestamp to Date
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, snow, sys
        case dtTxt = "dt_txt"
    }
}

//MARK: Forecast Main
/// Temperature and atmospheric data for a single forecast entry.
struct ForecastMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

//MARK: Forecast Sys
/// Part of day indicator for a forecast entry.
struct ForecastSys: Codable {
    let pod: String
}

//MARK: City
/// Metadata about the city associated with the forecast.
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}
