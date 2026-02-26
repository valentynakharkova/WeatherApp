//
//  WeatherDetailCard.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct WeatherDetailCard: View {
    
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                Text(title.uppercased())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.callout)
            .fontWeight(.medium)
            .colorModifier()

            Text(value)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(.white.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
            ]) {
                WeatherDetailCard(
                    icon: "sunset.fill",
                    title: "Sunset",
                    value: "18.30"
                )
                WeatherDetailCard(
                    icon: "humidity.fill",
                    title: "Humidity",
                    value: "10%"
                )
                WeatherDetailCard(
                    icon: "wind",
                    title: "Wind Speed",
                    value: "20 m/s"
                )
                WeatherDetailCard(
                    icon: "gauge.medium",
                    title: "Pressure",
                    value: "1000 hPa"
                )

        }
        
    }
}
