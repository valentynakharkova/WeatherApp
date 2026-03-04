//
//  TempereatureView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct TempereatureView: View {
    
    let weather: WeatherData
    
    @ObservedObject private var tempSettings = TemperatureSettings.shared
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text(weather.name)
                    .font(.system(size: 35, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.top, 60)
                Text(tempSettings.format(weather.main.temp))
                    .font(.system(size: 100, weight: .thin))
                    .foregroundStyle(.white)
            
                Text("Feels like: \(tempSettings.format(weather.main.feelsLike))")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack(spacing: 10) {
                    Text("H: \(tempSettings.format(weather.main.tempMax))")
                    Text("L: \(tempSettings.format(weather.main.tempMin))")
                }
                .font(.headline)
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        TempereatureView(weather: .mock)
    }
}
