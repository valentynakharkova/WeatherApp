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
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.white.opacity(0.5))

            Text(value)
                .font(.title)
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
