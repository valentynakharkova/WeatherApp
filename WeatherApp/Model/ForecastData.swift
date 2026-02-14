//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation

//MARK: Forecast Data
struct ForecastData: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastItem]
    let city: City
}

//MARK: Forecast Item
struct ForecastItem: Codable, Identifiable {
    let dt: Int
    let main: ForecastMain
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let snow: Snow?
    let sys: ForecastSys
    let dtTxt: String
    
    var id: Int { dt }
    
    //MARK: Helper to convert timestamp to Date
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, snow, sys
        case dtTxt = "dt_txt"
    }
}

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

//MARK: ForecastSys
struct ForecastSys: Codable {
    let pod: String
}

//MARK: City
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
