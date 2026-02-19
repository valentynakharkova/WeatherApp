//
//  WeatherPageView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 19.02.2026.
//

import SwiftUI

struct WeatherPageView: View {
    
    let weather: WeatherData
    let forecast: ForecastData?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                TempereatureView(weather: weather)
                
                if let forecast = forecast {
                    HourlyForecastView(forecast: forecast)
                }
                
                if let forecast = forecast {
                    DailyForecastView(forecast: forecast)
                }
                
                WeatherDetailsGrid(weather: weather)
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        WeatherPageView(weather: .mock, forecast: .mock)
    }
}
