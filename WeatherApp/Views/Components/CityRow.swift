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
    let onDelete: () -> Void
    
    @ObservedObject private var tempSetting = TemperatureSettings.shared
    
    @State private var isPressed = false
    @State private var offset: CGFloat = 0
    
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
                Text(tempSetting.format(weather.main.temp))
                    .font(.system(size: 50, weight: .thin))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
        .buttonStyle(.borderless)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        VStack(spacing: 12) {
            CityRow(city: .mockKyiv, weather: .mock, onTap: {}, onDelete: {})
            CityRow(city: .mockZaporizhzhia, weather: .mock, onTap: {}, onDelete: {})
            CityRow(city: .mockKyiv, weather: .mock, onTap: {}, onDelete: {})
            
        }
        .padding()
    }
}
