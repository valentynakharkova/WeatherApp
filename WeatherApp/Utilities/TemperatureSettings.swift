//
//  TemperatureSettings.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 04.03.2026.
//

import SwiftUI
import Combine

//MARK: Temperature Unit
enum TemperatureUnit {
    case celsius, fahrenheit
    
    var symbol: String {
        switch self {
        case .celsius: return "°C"
        case .fahrenheit: return "°F"
        }
    }
    
    var systemImage: String {
        switch self {
        case .celsius: return "degreesign.celsius"
        case .fahrenheit: return "degreesign.fahrenheit"
        }
    }
}

//MARK: Temperature Settings
class TemperatureSettings: ObservableObject {
    static let shared = TemperatureSettings()
    
    @Published var unit: TemperatureUnit = .celsius
    
    func convert(_ celsius: Double) -> Double {
        switch unit {
        case .celsius: return celsius
        case .fahrenheit: return (celsius * 9/5) + 32
        }
    }
    
    func format(_ celsius: Double) -> String {
        "\(Int(convert(celsius)))°"
    }
}
