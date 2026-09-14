//
//  TemperatureSettings.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 04.03.2026.
//

import SwiftUI
import Combine

//MARK: Temperature Unit
/// Represents the unit of temperature measurement.
/// Used to toggle between Celsius and Fahrenheit throughout the app.
enum TemperatureUnit {
    case celsius, fahrenheit
    
    /// The degree symbol string for the unit (e.g. "°C" or "°F")
    var symbol: String {
        switch self {
        case .celsius: return "°C"
        case .fahrenheit: return "°F"
        }
    }
    
    /// The SF Symbol name for the unit used in toolbar buttons
    var systemImage: String {
        switch self {
        case .celsius: return "degreesign.celsius"
        case .fahrenheit: return "degreesign.fahrenheit"
        }
    }
}

//MARK: Temperature Settings
/// A shared settings object that manages the selected temperature unit across the app.
/// Implemented as a singleton `ObservableObject` so all views react to unit changes automatically.
class TemperatureSettings: ObservableObject {
    
    // MARK: - Singleton
    /// Shared instance used across the entire app
    static let shared = TemperatureSettings()
    
    // MARK: - Published Properties
    /// The currently selected temperature unit. Defaults to Celsius.
    /// When changed, all observing views automatically re-render with the new unit.
    @Published var unit: TemperatureUnit = .celsius
    
    // MARK: - Methods
    /// Converts a temperature value from Celsius to the currently selected unit.
    /// - Parameter celsius: The temperature in Celsius to convert
    /// - Returns: The converted temperature value in the current unit
    func convert(_ celsius: Double) -> Double {
        switch unit {
        case .celsius: return celsius
        case .fahrenheit: return (celsius * 9/5) + 32
        }
    }
    
    /// Formats a Celsius temperature value into a display string using the current unit.
    /// Decimal places are dropped for a cleaner display (e.g. "23°" instead of "23.4°")
    /// - Parameter celsius: The temperature in Celsius to format
    /// - Returns: A formatted string with the converted temperature and degree symbol (e.g. "23°")
    func format(_ celsius: Double) -> String {
        "\(Int(convert(celsius)))°"
    }
}
