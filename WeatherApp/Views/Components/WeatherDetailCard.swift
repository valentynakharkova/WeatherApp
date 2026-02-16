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
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundStyle(.white)
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.8))
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(.white.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        WeatherDetailCard(
            icon: "humidity.fill",
            title: "Humidity",
            value: "65%"
        )
        .frame(width: 160)
        .padding()
    }
}
