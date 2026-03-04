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
            Text("3-HOURS FORECAST")
                .font(.callout)
                .colorModifier()
                .padding(.horizontal)
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(forecast.list.prefix(8)) { item in
                        HourlyForecastCard(item: item)
                    }
                }
                .padding(.horizontal, 5)

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
