//
//  WeatherDetailsGrid.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct WeatherDetailsGrid: View {
    
    let weather: WeatherData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("WEATHER DETAILS")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 20)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                WeatherDetailCard(
                    icon: "thermometer.medium",
                    title: "Feels like",
                    value: "\(Int(weather.main.feelsLike))°"
                )
                WeatherDetailCard(
                    icon: "sunrise.fill",
                    title: "Sunrise",
                    value: "\(weather.sys.sunrise.toTimeString())"
                )
                WeatherDetailCard(
                    icon: "sunset.fill",
                    title: "Sunset",
                    value: "\(weather.sys.sunset.toTimeString())"
                )
                WeatherDetailCard(
                    icon: "humidity.fill",
                    title: "Humidity",
                    value: "\(weather.main.humidity)%"
                )
                WeatherDetailCard(
                    icon: "wind",
                    title: "Wind Speed",
                    value: String(format: "%.1f m/s", weather.wind.speed)
                )
                WeatherDetailCard(
                    icon: "gauge.medium",
                    title: "Pressure",
                    value: "\(weather.main.pressure) hPa"
                )
                WeatherDetailCard(
                    icon: "eye.fill",
                    title: "Visibility",
                    value: "\(weather.visibility / 1000) km"
                )
                WeatherDetailCard(
                    icon: "cloud.fill",
                    title: "Clouds",
                    value: "\(weather.clouds.all)%"
                )
                
            }
        }
        .padding(10)
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        WeatherDetailsGrid(weather: .mock)
    }
}
