//
//  TempereatureView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct TempereatureView: View {
    
    let weather: WeatherData
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text(weather.name)
                    .font(.system(size: 35, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.top, 60)
                Text("\(Int(weather.main.temp))°")
                    .font(.system(size: 100, weight: .thin))
                    .foregroundStyle(.white)
            
                Text("Feels like: \(Int(weather.main.feelsLike))°")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack(spacing: 10) {
                    Text("H: \(Int(weather.main.tempMax))°")
                    Text("L: \(Int(weather.main.tempMin))°")
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
