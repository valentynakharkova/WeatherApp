//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct HourlyForecastView: View {
    
    let forecast: ForecastData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("hourly forecast".uppercased())
                .font(.callout)
                .foregroundStyle(.thinMaterial)
                
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(forecast.list.prefix(8)) { item in
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        HourlyForecastView(forecast: .mock)
    }
}
