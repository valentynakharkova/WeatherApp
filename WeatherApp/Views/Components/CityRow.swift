//
//  CityRow.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 17.02.2026.
//

import SwiftUI

struct CityRow: View {
    
    let city: GeocodingData
    let weather: WeatherData
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(city.name)
                        .font(.title)
                        .foregroundStyle(.white)
                    Text(city.displayName)
                        .font(.headline)
                        .colorModifier()
                }
                Spacer()
                Text("\(Int(weather.main.temp))°")
                    .font(.system(size: 50, weight: .thin))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
//        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        VStack(spacing: 12) {
            CityRow(city: .mockKyiv, weather: .mock, onTap: {})
            CityRow(city: .mockZaporizhzhia, weather: .mock, onTap: {})
            CityRow(city: .mockKyiv, weather: .mock, onTap: {})
            CityRow(city: .mockZaporizhzhia, weather: .mock, onTap: {})
            CityRow(city: .mockKyiv, weather: .mock, onTap: {})
        }
        .padding()
    }
}
