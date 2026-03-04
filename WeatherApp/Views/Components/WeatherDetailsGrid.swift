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
                .font(.callout)
                .colorModifier()
            
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
                    icon: "eye.fill",
                    title: "Visibility",
                    value: weather.visibility.map { "\($0 / 1000) km"} ?? "--"
                )
                WeatherDetailCard(
                    icon: "sunrise.fill",
                    title: "Sunrise",
                    value: "\(weather.formatTime(weather.sys.sunrise))"
                )
                WeatherDetailCard(
                    icon: "sunset.fill",
                    title: "Sunset",
                    value: "\(weather.formatTime(weather.sys.sunset))"
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
                    icon: "cloud.fill",
                    title: "Clouds",
                    value: "\(weather.clouds.all)% "
                )
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        WeatherDetailsGrid(weather: .mock)
    }
}
