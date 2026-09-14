//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Valentyna Kharkova on 12.02.2026.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    
    // MARK: - TemperatureSettings Tests
    
    /// Tests that 0°C correctly converts to 32°F
    @MainActor
    func testCelsiusToFahrenheit() {
        // Given
        let settings = TemperatureSettings()
        settings.unit = .fahrenheit
        
        // When
        let result = settings.convert(0)
        
        // Then
        XCTAssertEqual(result, 32)
    }
    
    /// Tests that -40°C equals -40°F — the only point where both scales are equal
    @MainActor
    func testNegativeTemperatureConversion() {
        // Given
        let settings = TemperatureSettings()
        settings.unit = .fahrenheit
        
        // When
        let result = settings.convert(-40)
        
        // Then
        XCTAssertEqual(result, -40)
    }
    
    /// Tests that format() returns a correctly formatted string with degree symbol
    @MainActor
    func testFormatOutput() {
        // Given
        let settings = TemperatureSettings()
        settings.unit = .fahrenheit
        
        // When
        let result = settings.format(100) // 100°C = 212°F
        
        // Then
        XCTAssertEqual(result, "212°")
    }
    
    // MARK: - WeatherData.formatTime Tests
    
    /// Tests that formatTime correctly converts a UTC timestamp using a positive timezone offset.
    /// This was a real bug in the app — sunrise/sunset were showing in device timezone instead of city timezone.
    func testFormatTimeWithPositiveOffset() {
        // Given — Kyiv timezone (UTC+2 = 7200 seconds)
        let weather = WeatherData.mock
        
        // When
        let result = weather.formatTime(weather.sys.sunrise)
        
        // Then
        XCTAssertEqual(result, "08:30")
    }
    
    /// Tests that formatTime correctly handles UTC timezone (offset = 0)
    func testFormatTimeWithZeroOffset() {
        // Given — London timezone (UTC+0)
        let weather = WeatherData.mockCloudy
        
        // When
        let result = weather.formatTime(weather.sys.sunrise)
        
        // Then
        XCTAssertEqual(result, "07:30")
    }
    
    // MARK: - GeocodingData Tests
    
    /// Tests that displayName includes state when available
    func testDisplayNameWithState() {
        // Given
        let city = GeocodingData.mockZaporizhzhia
        
        // When
        let result = city.displayName
        
        // Then
        XCTAssertEqual(result, "Zaporizhzhia, Zaporizhzhia Oblast, UA")
    }
    
    /// Tests that displayName excludes state when nil
    func testDisplayNameWithoutState() {
        // Given
        let city = GeocodingData.mockKyiv
        
        // When
        let result = city.displayName
        
        // Then
        XCTAssertEqual(result, "Kyiv, UA")
    }
    
    // MARK: - SavedCityManager Tests
    
    /// Tests that duplicate cities cannot be saved
    func testNoDuplicateCities() {
        // Given
        let manager = SavedCityManager.shared
        manager.updateCities([])
        
        // When
        manager.saveCity(.mockKyiv)
        manager.saveCity(.mockKyiv)
        
        // Then
        XCTAssertEqual(manager.savedCities.count, 1)
    }
    
    /// Tests that a city can be removed successfully
    func testRemoveCity() {
        // Given
        let manager = SavedCityManager.shared
        manager.updateCities([.mockKyiv, .mockZaporizhzhia])
        
        // When
        manager.removeCity(.mockKyiv)
        
        // Then
        XCTAssertEqual(manager.savedCities.count, 1)
        XCTAssertEqual(manager.savedCities.first?.name, "Zaporizhzhia")
    }
    
    /// Tests that the city limit of 5 is strictly enforced
    func testCityLimit() {
        // Given
        let manager = SavedCityManager.shared
        manager.updateCities([])
        
        let cities: [GeocodingData] = [
            .mockKyiv,
            .mockZaporizhzhia,
            GeocodingData(name: "Lviv", localNames: nil, lat: 49.84, lon: 24.02, country: "UA", state: nil),
            GeocodingData(name: "Odesa", localNames: nil, lat: 46.47, lon: 30.73, country: "UA", state: nil),
            GeocodingData(name: "Kharkiv", localNames: nil, lat: 49.99, lon: 36.23, country: "UA", state: nil),
            GeocodingData(name: "Dnipro", localNames: nil, lat: 48.46, lon: 35.04, country: "UA", state: nil)
        ]
        
        // When
        cities.forEach { manager.saveCity($0) }
        
        // Then
        XCTAssertEqual(manager.savedCities.count, 5)
    }
}
