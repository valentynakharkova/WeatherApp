//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService()
    
    func getWeather(for city: String) async {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                let data = try await weatherService.fetchWeather(for: city)
                weatherData = data
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
